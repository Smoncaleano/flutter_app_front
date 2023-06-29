import 'package:flutter/material.dart';
import 'package:flutter_application_1/Pages/pagina_1.dart';
import 'package:flutter_application_1/Provider/pagos_provider.dart';
import 'package:flutter_application_1/Provider/sueldo_provider.dart';

import 'package:flutter_application_1/theme/app_theme.dart';
import 'package:provider/provider.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => SueldoProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => PagosProvider(),
        )
      ],
      child: MaterialApp(
        theme: AppTheme(selectColor: 3).theme(),
        debugShowCheckedModeBanner: false,
        home: FirstPage(),
      ),
    );
  }
}
