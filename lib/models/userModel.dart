import 'package:flutter/cupertino.dart';

class UserModel with ChangeNotifier {
  final String  empresa, direccion, rif, phone, email, desde, hasta, userId, image;
  final String? password;
  final List canchas;

  UserModel({
    required this.empresa,
    required this.direccion,
    required this.rif,
    required this.phone,
    required this.desde,
    required this.hasta,
    required this.userId,
    required this.image,
    required this.canchas,
    this.password,
    required this.email,
  });
}