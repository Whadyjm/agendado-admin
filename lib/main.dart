import 'package:agendado_admin/authPages/login.dart';
import 'package:agendado_admin/firebase_options.dart';
import 'package:agendado_admin/view/home.dart';
import 'package:agendado_admin/view/webPage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});


  @override
  Widget build(BuildContext context) {

    final screenPage = MediaQuery.sizeOf(context).width > 600;

    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
          useMaterial3: true,
        ),
        home: screenPage
            ? const Home()
            : const Home(),
      );
  }
}