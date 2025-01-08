import 'package:agendado_admin/models/userModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class UserProvider with ChangeNotifier {

  UserModel? userModel;
  UserModel? get getUserModel {
    return userModel;
  }

  Future<UserModel?> fetchUserInfo() async {

    final auth = FirebaseAuth.instance;
    User? user = auth.currentUser;

    if (user == null){
      return null;
    }
    String uid = user.uid;
    try{
      final userDoc = await FirebaseFirestore.instance.collection('users').doc(uid).get();

      final userDocDict = userDoc.data();

      userModel = UserModel(
        userId: userDoc.get('userID'),
        empresa: userDoc.get('empresa'),
        rif: userDoc.get('rif'),
        direccion: userDoc.get('direccion'),
        phone: userDoc.get('phone'),
        email: userDoc.get('email'),
        desde: userDoc.get('desde'),
        hasta: userDoc.get('hasta'),
        image: userDoc.get('image'),
        canchas: userDocDict!.containsKey("canchas") ? userDoc.get("canchas") : [],
      );
      return userModel;
    } on FirebaseException catch(e){
      rethrow;
    }catch(e){
      rethrow;
    }
  }
}