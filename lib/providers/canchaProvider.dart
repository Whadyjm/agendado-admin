import 'package:agendado_admin/models/canchaModel.dart';
import 'package:agendado_admin/models/userModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class CanchaProvider with ChangeNotifier {

  CanchaModel? canchaModel;
  CanchaModel? get getCanchaModel {
    return canchaModel;
  }

  Future<CanchaModel?> fetchCanchaInfo() async {

    final auth = FirebaseAuth.instance;
    User? user = auth.currentUser;

    if (user == null){
      return null;
    }
    String uid = user.uid;
    try{
      final canchaDoc = await FirebaseFirestore.instance.collection('canchas').doc('cancha de ${user!.email}').get();

      final canchaDocDict = canchaDoc.data();

      canchaModel = CanchaModel(
          image: '',
          cancha: canchaDoc.get('cancha'),
          disponible: canchaDoc.get('disponible'),
          techada: canchaDoc.get('techada')
      );
      return canchaModel;
    } on FirebaseException catch(e){
      rethrow;
    }catch(e){
      rethrow;
    }
  }
}