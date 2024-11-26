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
      final userDoc = await FirebaseFirestore.instance.collection('users').doc(user.email).get();

      final userDocDict = userDoc.data();

      userModel = UserModel(
        empresa: userDoc.get('empresa'),
        rif: userDoc.get('rif'),
        phone: userDoc.get('phone'),
        email: userDoc.get('email'),
      );
      return userModel;
    } on FirebaseException catch(e){
      rethrow;
    }catch(e){
      rethrow;
    }
  }
}