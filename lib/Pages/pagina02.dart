import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/DTO/comision.dart';

import 'package:http/http.dart' as http;

class Pagina02 extends StatelessWidget {
  Pagina02({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Coomeva fernando",
      home: Listado(),
    );
  }
}

class Listado extends StatefulWidget {
  const Listado({super.key});

  @override
  State<Listado> createState() => _ListadoState();
}

class _ListadoState extends State<Listado> {
  late Future<List<Comision>> comisiones;
  List<Comision> items = [];

  Future<List<Comision>> getComision() async {
    final response =
        await http.get(Uri.parse("http://10.0.2.2:8080/Comisions"));

    if (response.statusCode == 200) {
      Iterable it = jsonDecode(response.body);
      List<Comision> posts =
          List<Comision>.from(it.map((model) => Comision.fromJson(model)));
      print(posts);

      return posts;
    } else {
      throw Exception("Falló la conexión");
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Listado clientes')),
        body: (FutureBuilder<List<Comision>>(
            future: getComision(),
            builder: (context, AsyncSnapshot<List<Comision>> snapshot) {
              if (snapshot.hasData) {
                items = snapshot.data!.toList();
                return ListView.builder(
                    itemCount: items.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                          onLongPress: () => {
                                print(snapshot.data!.toList().length),
                                print(items[index].contrato)
                              },
                          title: Text(items[index].nitContratante +
                              ' ' +
                              items[index].nombreUsuario),
                          leading: CircleAvatar(
                            child: Text(
                                items[index].nombreUsuario.substring(0, 1)),
                          ));
                    });
              }
              return CircularProgressIndicator();
            })));
  }

  /*
  title: Text(comisiones[index].nitContratante +
                    ' ' +
                    comisiones[index].nombreUsuario),
                subtitle: Text(comisiones[index].comision.toString()),
                leading: CircleAvatar(
                  child: Text(comisiones[index].nombreUsuario.substring(0, 1)),*/

  borrarCliente(context, Comision comision) {
    showDialog(
        context: context,
        builder: (_) => AlertDialog(
              title: Text("Eliminar cliente"),
              content: Text("¿Está seguro de querer eliminar el cliente " +
                  comision.nombreUsuario +
                  " ?"),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text("Cancelar")),
                TextButton(
                    onPressed: () {
                      setState(() {});
                      Navigator.pop(context);
                    },
                    child: Text("Borrar",
                        style: TextStyle(
                          color: Colors.red[300],
                        )))
              ],
            ));
  }
}
