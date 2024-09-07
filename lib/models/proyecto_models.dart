import 'dart:convert';

Proyecto proyectoFromJson(String str) => Proyecto.fromJson(json.decode(str));

String proyectoToJson(Proyecto data) => json.encode(data.toJson());

class Proyecto {
  String? id;
  String? nombre;
  DateTime? fecha_inicio;
  DateTime? fecha_fin;

  Proyecto({
    this.id,
    this.nombre,
    this.fecha_inicio,
    this.fecha_fin,
  });

  factory Proyecto.fromJson(Map<String, dynamic> json) => Proyecto(
    id: json["id"].toString(),
    nombre: json["nombre"],
    fecha_inicio: DateTime.tryParse(json["fecha_inicio"]) ?? DateTime.now(),
    fecha_fin: DateTime.tryParse(json["fecha_fin"]) ?? DateTime.now(),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "nombre": nombre,
    "fecha_inicio": fecha_inicio?.toIso8601String(), // Mejor formato para fechas
    "fecha_fin": fecha_fin?.toIso8601String(), // Mejor formato para fechas
  };
}
