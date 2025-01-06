import 'package:agendado_admin/authPages/login.dart';
import 'package:agendado_admin/models/canchaModel.dart';
import 'package:agendado_admin/models/userModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class CanchaProvider with ChangeNotifier {

  final Map<String, CanchaModel> _canchasItems = {};
  Map<String, CanchaModel> get getCanchas {
    return _canchasItems;
  }

  final userCanchaDb = FirebaseFirestore.instance.collection('users');
  final _auth = FirebaseAuth.instance;

  Future<void> addCancha({
    required String nombreCancha,
    required bool techada,
    required bool disponible,
    required BuildContext context,
  }) async {
    final User? user = _auth.currentUser;
    if (user == null) {
      Navigator.push(context, MaterialPageRoute(builder: (context){
        return Login();
      }));
      return;
    }
    final uid = user.uid;
    final publishId = const Uuid().v4();
    try {
      await userCanchaDb.doc(user.uid).update({
        'canchas': FieldValue.arrayUnion([
          {
            'userId':user.uid,
            'publishId': publishId,
            'cancha': nombreCancha,
            'techada': techada,
            'disponible': disponible,
          }
        ])
      });
      await fetchCanchaList();
    } catch (e) {
      rethrow;
    }finally{
      Navigator.pop(context);
    }
  }

  Future<void> fetchCanchaList() async {
    final User? user = _auth.currentUser;
    if (user == null) {
      _canchasItems.clear();
      return;
    }
    try {
      final userDoc = await userCanchaDb.doc(user.uid).get();
      final data = userDoc.data();
      if (data == null || !data.containsKey('canchas')) {
        return;
      }
      final length = userDoc.get("canchas").length;
      for (int index = 0; index < length; index++) {
        _canchasItems.putIfAbsent(
            userDoc.get("canchas")[index]['cancha'],
                () => CanchaModel(
                  image: '',
                  cancha: userDoc.get('canchas')[index]['cancha'],
                  disponible: userDoc.get('canchas')[index]['techada'],
                  techada: userDoc.get('canchas')[index]['disponible'],
                  userId: userDoc.get('canchas')[index]['userId'],
            ));
      }
      await fetchCanchaList();
    } catch (e) {
      rethrow;
    }
    notifyListeners();
  }
}