// To parse this JSON data, do
//
//     final getTelevisiones = getTelevisionesFromMap(jsonString);

import 'dart:convert';

class GetTelevisiones {
    GetTelevisiones({
        required this.id,
        required this.modelo,
        required this.area,
        required this.resolucion,
        required this.foto,
        required this.encendido,
        required this.enLinea,
    });

    int id;
    String modelo;
    int area;
    int resolucion;
    String foto;
    bool encendido;
    bool enLinea;

    factory GetTelevisiones.fromJson(String str) => GetTelevisiones.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory GetTelevisiones.fromMap(Map<String, dynamic> json) => GetTelevisiones(
        id: json["id"],
        modelo: json["modelo"],
        area: json["area"],
        resolucion: json["resolucion"],
        foto: json["foto"],
        encendido: json["encendido"],
        enLinea: json["en_linea"],
    );

    Map<String, dynamic> toMap() => {
        "id": id,
        "modelo": modelo,
        "area": area,
        "resolucion": resolucion,
        "foto": foto,
        "encendido": encendido,
        "en_linea": enLinea,
    };
}
