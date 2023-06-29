import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter_application_1/services/connection_service.dart';
import 'package:http/http.dart' as http;

class ApiManager {
  final ConnectionService connectionService;

  late http.Client client;

  ApiManager({required this.connectionService}) {
    client = connectionService.returnConnection();
  }

  ///[serviceCode] Service code to send in traceability, in case it does not apply to send it empty Eg:
  /// ```dart
  /// serviceCode: "",
  /// ```
  ///This code may not apply in case the service is there before the user logs in and the code has not yet been saved token
  Future<dynamic> postAPICall(String url,
      {Object? body, Map<String, String>? headers}) async {
    dynamic responseJson;
    try {
      final request = await client.post(
        Uri.parse(url),
        body: body,
        headers: headers,
      );

      responseJson = _response(request);
    } on SocketException {
      throw Exception("Error");
    }
    return responseJson;
  }

  Future<dynamic> getAPICall(String url,
      {Map<String, String>? headers,
      Duration timeLimit = const Duration(seconds: 80)}) async {
    dynamic responseJson;
    try {
      final request = await client.get(Uri.parse(url), headers: headers);

      responseJson = _response(request);
    } on SocketException {
      throw Exception("Error de conexión");
    }
    return responseJson;
  }

  _response(response) {
    switch (response.statusCode) {
      case 200:
        // TODO: se necesita la validacion del content-type que devuelve la api para evitar que se intente parsear textos planos ( si se necesita consultar crear otro response)
        if (response.body != null && response.body.toString().isNotEmpty) {
          if (response.headers['content-type']
              .toString()
              .contains("text/plain")) {
            return response.body.toString();
          }
          var responseJson = json.decode(response.body.toString());
          return responseJson;
        } else {
          return 'OK';
        }
      case 201:
        if (response.body != null && response.body.toString().isNotEmpty) {
          if (response.headers['content-type']
              .toString()
              .contains("text/plain")) {
            return response.body.toString();
          }
          var responseJson = json.decode(response.body.toString());
          return responseJson;
        } else {
          return 'OK';
        }
      case 400:
        throw Exception(response.body.toString());
      case 401:
      case 403:
        throw Exception(response.body.toString());
      case 500:
      default:
        throw Exception(response.body.toString());
    }
  }
}
