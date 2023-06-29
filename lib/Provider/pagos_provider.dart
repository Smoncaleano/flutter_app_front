import 'package:flutter/foundation.dart';
import 'package:flutter_application_1/DTO/pagos.dart';
import 'package:flutter_application_1/utils/utils.dart';

class PagosProvider extends ChangeNotifier {
  final Utils utils = Utils();

  bool estado = false;

  List<Pagos> pagos = [];

  Future<List<Pagos>> getPagos(String pagaron) async {
    List<Pagos> pagoss = await utils.getPagos(pagaron);
    pagos = pagoss;
    return pagoss;
  }

  Future<void> actualizarPagos() async {
    notifyListeners();
  }

  Future<void> actualizarEstado() async {
    await Future.delayed(Duration(milliseconds: 200));
    estado = true;
    notifyListeners();
  }
}
