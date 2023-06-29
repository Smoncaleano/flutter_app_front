import 'package:flutter/material.dart';
import 'package:flutter_application_1/utils/utils.dart';

class SueldoProvider extends ChangeNotifier {
  String sueldo = '';

  final Utils utils = Utils();

  Future<String> consumirFile() async {
    String result = '';

    result = await utils.selectFile();

    sueldo = result;
    notifyListeners();

    return result;
  }
}
