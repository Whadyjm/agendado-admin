import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class CanchaModel with ChangeNotifier{
  late String image;
  late String cancha;
  late bool disponible;
  late bool techada;

  CanchaModel({
    required this.image,
    required this.cancha,
    required this.disponible,
    required this.techada
});

  factory CanchaModel.fromFirestore(DocumentSnapshot doc) {
    Map data = doc.data() as Map<String, dynamic>;
    // data.containsKey("")
    return CanchaModel(
        image: data['canchaImage'],
        cancha: data['cancha'],
        disponible: data['disponible'],
        techada: data['techada'],
    );
  }

}