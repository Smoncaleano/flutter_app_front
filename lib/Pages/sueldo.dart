// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_application_1/DTO/pagos.dart';
import 'package:flutter_application_1/Provider/pagos_provider.dart';
import 'package:flutter_application_1/Provider/sueldo_provider.dart';
import 'package:flutter_application_1/theme/app_theme.dart';
import 'package:provider/provider.dart';

void main() => runApp(Sueldo());

class Sueldo extends StatelessWidget {
  Sueldo({super.key});

  bool mostrar = false;
  String tipoParametro =
      'Mayor'; // Variable para almacenar el tipo de parámetro utilizado en getPagos

  @override
  Widget build(BuildContext context) {
    final chatProvider = context.watch<SueldoProvider>();
    final pagosProvider = context.watch<PagosProvider>();

    return MaterialApp(
      theme: AppTheme(selectColor: 3).theme(),
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(title: Text('Sueldo')),
        body: Center(
          child: Column(
            children: [
              ElevatedButton(
                onPressed: () {
                  chatProvider.consumirFile();
                  pagosProvider.actualizarEstado();
                },
                child: Text('Subir archivo'),
              ),
              SizedBox(height: 10),
              _TextoSueldo(texto: 'Tu sueldo es de: ${chatProvider.sueldo}'),
              SizedBox(height: 10),
              Visibility(
                visible: pagosProvider.estado,
                child: Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          // Actualizar el tipo de parámetro y llamar a getPagos
                          tipoParametro = 'Mayor';
                          pagosProvider.getPagos(tipoParametro);
                          pagosProvider.actualizarPagos();
                        },
                        child: Text('Pagaron'),
                      ),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          // Actualizar el tipo de parámetro y llamar a getPagos
                          tipoParametro = 'Menor';
                          pagosProvider.getPagos(tipoParametro);
                          pagosProvider.actualizarPagos();
                        },
                        child: Text('No pagaron'),
                      ),
                    ),
                  ],
                ),
              ),
              FutureBuilder<List<Pagos>>(
                future: pagosProvider.getPagos(
                    tipoParametro), // Utilizar el tipo de parámetro actualizado
                builder: (context, AsyncSnapshot<List<Pagos>> snapshot) {
                  if (snapshot.hasData && pagosProvider.estado) {
                    List<Pagos> items = snapshot.data!.toList();
                    return Expanded(
                      child: ListView.builder(
                        itemCount: items.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(7),
                                color: Colors.green.shade50,
                              ),
                              child: ListTile(
                                onLongPress: () => {},
                                title: Text(
                                  items[index].nitContratante +
                                      ' ' +
                                      items[index].nombreContratante,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                leading: CircleAvatar(
                                  child: Text(
                                    items[index].nombreUsuario.substring(0, 1),
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                subtitle: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Doc Usuario: ${items[index].docUsuario}',
                                    ),
                                    Text(
                                      'Nombre Usuario: ${items[index].nombreUsuario}',
                                    ),
                                    Text(
                                      'Comisión Pagada: ${items[index].comisionPagada}',
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    );
                  }
                  return CircularProgressIndicator();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _TextoSueldo extends StatelessWidget {
  const _TextoSueldo({
    required this.texto,
  });

  final String texto;

  @override
  Widget build(BuildContext context) {
    return Text(
      texto,
      style: TextStyle(
        fontSize: 30,
        fontFamily: AutofillHints.countryName,
        color: Colors.black87,
      ),
    );
  }
}
