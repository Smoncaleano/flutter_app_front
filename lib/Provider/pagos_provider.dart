import 'package:flutter/foundation.dart';
import 'package:flutter_application_1/DTO/pagos.dart';
import 'package:flutter_application_1/utils/utils.dart';

class PagosProvider extends ChangeNotifier {
  final Utils utils = Utils();

  bool estado = false;

  List<Pagos> pagos = [];

  String tipoParametro = 'Mayor';

  Future<List<Pagos>> getPagos() async {
    List<Pagos> pagoss = await utils.getPagos(tipoParametro);
    pagos = pagoss;
    return pagoss;
  }

  Future<void> actualizarPagos(String tipo) async {
    tipoParametro = tipo;
    notifyListeners();
  }

  Future<void> actualizarEstado() async {
    await Future.delayed(Duration(milliseconds: 200));
    estado = true;
    notifyListeners();
  }
}
