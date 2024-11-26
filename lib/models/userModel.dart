import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class UserModel with ChangeNotifier {
  final String  empresa, direccion, rif, phone, email, desde, hasta;
  final String? password;

  UserModel({
    required this.empresa,
    required this.direccion,
    required this.rif,
    required this.phone,
    required this.desde,
    required this.hasta,
    this.password,
    required this.email,
  });
}