import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class UserModel with ChangeNotifier {
  final String  empresa, rif, phone, email;
  final String? password;

  UserModel({
    required this.empresa,
    required this.rif,
    required this.phone,
    this.password,
    required this.email,
  });
}