// To parse this JSON data, do
//
//     final pagos = pagosFromJson(jsonString);

import 'dart:convert';

Pagos pagosFromJson(String str) => Pagos.fromJson(json.decode(str));

String pagosToJson(Pagos data) => json.encode(data.toJson());

class Pagos {
  final String contrato;
  final String nitContratante;
  final String nombreContratante;
  final String docUsuario;
  final String nombreUsuario;
  final String plan;
  final String programa;
  final String subPrograma;
  final String novedad;
  final String valorCuota;
  final int comisionPagada;

  Pagos({
    required this.contrato,
    required this.nitContratante,
    required this.nombreContratante,
    required this.docUsuario,
    required this.nombreUsuario,
    required this.plan,
    required this.programa,
    required this.subPrograma,
    required this.novedad,
    required this.valorCuota,
    required this.comisionPagada,
  });

  factory Pagos.fromJson(Map<String, dynamic> json) => Pagos(
        contrato: json["contrato"],
        nitContratante: json["nitContratante"],
        nombreContratante: json["nombreContratante"],
        docUsuario: json["docUsuario"],
        nombreUsuario: json["nombreUsuario"],
        plan: json["plan"],
        programa: json["programa"],
        subPrograma: json["subPrograma"],
        novedad: json["novedad"],
        valorCuota: json["valorCuota"],
        comisionPagada: json["comisionPagada"],
      );

  Map<String, dynamic> toJson() => {
        "contrato": contrato,
        "nitContratante": nitContratante,
        "nombreContratante": nombreContratante,
        "docUsuario": docUsuario,
        "nombreUsuario": nombreUsuario,
        "plan": plan,
        "programa": programa,
        "subPrograma": subPrograma,
        "novedad": novedad,
        "valorCuota": valorCuota,
        "comisionPagada": comisionPagada,
      };
}
