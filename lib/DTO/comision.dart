import 'dart:convert';

Comision comisionFromJson(String str) => Comision.fromJson(json.decode(str));

String comisionToJson(Comision data) => json.encode(data.toJson());

class Comision {
  final int id;
  final String contrato;
  final String nitContratante;
  final String nombreContratante;
  final String docUsuario;
  final String nombreUsuario;
  final String plan;
  final String programa;
  final String subPrograma;
  final String novedad;
  final bool activo;

  Comision({
    required this.id,
    required this.contrato,
    required this.nitContratante,
    required this.nombreContratante,
    required this.docUsuario,
    required this.nombreUsuario,
    required this.plan,
    required this.programa,
    required this.subPrograma,
    required this.novedad,
    required this.activo,
  });

  factory Comision.fromJson(Map<String, dynamic> json) => Comision(
        id: json["id"],
        contrato: json["contrato"],
        nitContratante: json["nitContratante"],
        nombreContratante: json["nombreContratante"],
        docUsuario: json["docUsuario"],
        nombreUsuario: json["nombreUsuario"],
        plan: json["plan"],
        programa: json["programa"],
        subPrograma: json["subPrograma"],
        novedad: json["novedad"],
        activo: json["activo"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "contrato": contrato,
        "nitContratante": nitContratante,
        "nombreContratante": nombreContratante,
        "docUsuario": docUsuario,
        "nombreUsuario": nombreUsuario,
        "plan": plan,
        "programa": programa,
        "subPrograma": subPrograma,
        "novedad": novedad,
        "activo": activo,
      };
}
