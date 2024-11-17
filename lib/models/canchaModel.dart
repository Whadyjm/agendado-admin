import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class CanchaModel with ChangeNotifier{
  late String image;
  late String nombre;
  late bool disponible;

  CanchaModel({
    required this.image,
    required this.nombre,
    required this.disponible,
});

  factory CanchaModel.fromFirestore(DocumentSnapshot doc) {
    Map data = doc.data() as Map<String, dynamic>;
    // data.containsKey("")
    return CanchaModel(
        image: data['canchaImage'],
        nombre: data['cancha'],
        disponible: data['disponible'],
    );
  }

}