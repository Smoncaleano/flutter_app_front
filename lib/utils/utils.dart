// ignore_for_file: unnecessary_cast

import 'dart:io';
import 'dart:convert';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_application_1/DTO/pagos.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import '../DTO/response_generic.dart';
import 'package:permission_handler/permission_handler.dart';

class Utils {
  Future<void> requestFilePermissions() async {
    if (await Permission.storage.request().isGranted) {
      // El permiso ya está concedido.
    } else {
      // Si el permiso no está concedido, solicítalo.
      PermissionStatus status = await Permission.storage.request();
      if (status.isDenied) {
        // El permiso fue negado por el usuario, muestra un mensaje o realiza una acción en consecuencia.
      } else if (status.isPermanentlyDenied) {
        // El permiso fue negado permanentemente por el usuario, muestra un mensaje o realiza una acción en consecuencia.
      }
    }
  }

  static Future<PermissionStatus> requestPermission(
      {required Permission permission}) async {
    final status = await permission.request();
    return status;
  }

  Future<String> selectFile() async {
    String valor = '';

    if (await requestPermission(permission: Permission.storage).isGranted) {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['xlsx'],
        withData: true,
        allowMultiple: false,
      );

      if (result != null) {
        PlatformFile file = result.files.first;

        // Abre el archivo en modo de lectura binaria y obtén su contenido en bytes
        List<int> fileBytes = await File(file.path!).readAsBytes();

        // Crea un http.MultipartFile con el contenido del archivo
        http.MultipartFile multipartFile = http.MultipartFile.fromBytes(
          'file', // Nombre del campo del archivo en el multipart
          fileBytes, // Contenido del archivo en bytes
          filename: 'file.xlsx', // Nombre del archivo
          contentType: MediaType('application',
              'vnd.openxmlformats-officedocument.spreadsheetml.sheet'), // Tipo de contenido del archivo
        );
        // Crea una instancia de http.MultipartRequest
        var request = http.MultipartRequest(
          'POST', // Método HTTP para la solicitud
          Uri.parse('http://10.0.2.2:8080/Sum'), // URL del endpoint de destino
        );

        // Adjunta el archivo multipart al request
        request.files.add(multipartFile);

        var response = await request.send();

        // Lee la respuesta como texto
        var responseData = await response.stream.bytesToString();

        Map<String, dynamic> jsonResponse = jsonDecode(responseData);

        dynamic value = jsonResponse['data'];
        if (value is int) {
          String stringValue = value.toString();
          jsonResponse['data'] = stringValue;
        }

        final responses = ApiBaseResponse<String?>.fromJson(
            jsonResponse as Map<String, dynamic>);

        valor = responses.data.toString();
      }
    }

    return valor;
  }

  Future<List<Pagos>> getPagos(String pagaron) async {
    var request = await http
        .get(Uri.parse('http://10.0.2.2:8080/Pagaron/2023-06-28/$pagaron'));

    Iterable it = jsonDecode(request.body);
    List<Pagos> posts =
        List<Pagos>.from(it.map((model) => Pagos.fromJson(model)));

    return posts;
  }
}
