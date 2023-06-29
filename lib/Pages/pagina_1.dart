// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_application_1/Pages/pagina02.dart';
import 'package:flutter_application_1/Pages/sueldo.dart';
import 'package:flutter_application_1/theme/app_theme.dart';

void main() => runApp(const FirstPage());

class FirstPage extends StatelessWidget {
  const FirstPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Coomeva',
      theme: AppTheme(selectColor: 3).theme(),
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Coomeva'),
          leading: Padding(
            padding: EdgeInsets.all(4.0),
            child: CircleAvatar(
              backgroundImage: AssetImage('assets/images/1606412678927.jpg'),
            ),
          ),
        ),
        body: Center(
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            ElevatedButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Listado()));
              },
              child: Text(
                'Listado de clientes',
                style: TextStyle(fontSize: 25),
              ),
            ),
            SizedBox(
              height: 80,
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => Sueldo()));
              },
              child: Text(
                'Calcular sueldo',
                style: TextStyle(fontSize: 25),
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
