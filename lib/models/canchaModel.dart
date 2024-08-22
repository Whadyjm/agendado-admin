import 'package:flutter/cupertino.dart';

class CanchaModel {
  late String image;
  late String nombre;
  late bool disponible;
  late DateTime fecha;

  CanchaModel({
    required this.image,
    required this.nombre,
    required this.disponible,
    required this.fecha,
});
}