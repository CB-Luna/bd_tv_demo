// To parse this JSON data, do
//
//     final getAreasTrabajo = getAreasTrabajoFromMap(jsonString);

import 'dart:convert';

class GetAreasTrabajo {
    GetAreasTrabajo({
        required this.idAreaPk,
        required this.nombreArea,
    });

    int idAreaPk;
    String nombreArea;

    factory GetAreasTrabajo.fromJson(String str) => GetAreasTrabajo.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory GetAreasTrabajo.fromMap(Map<String, dynamic> json) => GetAreasTrabajo(
        idAreaPk: json["id_area_pk"],
        nombreArea: json["nombre_area"],
    );

    Map<String, dynamic> toMap() => {
        "id_area_pk": idAreaPk,
        "nombre_area": nombreArea,
    };
}
