// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/Pages/pagina02.dart';

import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';

import '../DTO/response_generic.dart';

bool suscrito = false;

class tabla extends StatelessWidget {
  Widget cuerpo(context) {
    return Container(
        child: Column(children: <Widget>[
      Text("Home"),
      ElevatedButton(
          onPressed: () => {
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => Listado()))
              },
          child: Text("Ir a listado de clientes")),
      ElevatedButton(
          onPressed: () => {_selectFile()}, child: Text("Subir archivo")),
      ElevatedButton(
        autofocus: true,
        style: ElevatedButton.styleFrom(
          primary: const Color.fromARGB(255, 207, 0, 17),
          textStyle: const TextStyle(color: Colors.white, fontSize: 17),
        ),
        onPressed: () {
          showDialog(
              barrierDismissible: false,
              context: context,
              builder: (_) => new AlertDialog(
                    actions: [
                      TextButton(
                          onPressed: () =>
                              {print("No"), Navigator.pop(context)},
                          child: Text("No")),
                      TextButton(
                          onPressed: () =>
                              {print("Si"), Navigator.pop(context)},
                          child: Text("Si"))
                    ],
                    title: Text("Confirmación"),
                    content: Text("¿Está seguro?"),
                  ));
        },
        child: const Text('Alert dialog'),
      ),
      Text(
        suscrito ? "Confirmado" : "No confirmado",
        style: TextStyle(fontSize: 20),
      )
    ]));
  }

  void _selectFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['xlsx'],
      withData: true,
      allowMultiple: false,
    );

    if (result != null) {
      PlatformFile file = result.files.first;

      debugPrint("extension ${file.extension}");
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

      print("asukgfaskgfsa");
      print(jsonResponse);

      dynamic value = jsonResponse['data'];
      if (value is int) {
        String stringValue = value.toString();
        jsonResponse['data'] = stringValue;
      }

      final responseS = ApiBaseResponse<String?>.fromJson(
          jsonResponse as Map<String, dynamic>);

      print("2");
      print(responseS.toString());
      print(responseS.data);
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }
}
