import 'package:agendado_admin/appConstantes.dart';
import 'package:agendado_admin/widgets/agregarCancha.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Canchas extends StatefulWidget {
  const Canchas({super.key});

  @override
  State<Canchas> createState() => _CanchasState();
}

class _CanchasState extends State<Canchas> {

  @override
  Widget build(BuildContext context) {

    User? user = FirebaseAuth.instance.currentUser;

    final  screenSize = MediaQuery.sizeOf(context).width > 600;
    return Scaffold(
      floatingActionButton:
      screenSize
          ? Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 30),
            child: FloatingActionButton.extended(
              backgroundColor: AppConstants.darkBlue,
              onPressed: () async {
                showDialog(context: context, builder: (context){
                  return const AgregarCancha();
                });
              }, label: const Text('Añadir cancha', style: TextStyle(color: Colors.white),),
              icon: const Icon(Icons.add, color: Colors.white,),
            ),
          ),
        ],
      )
      : FloatingActionButton.extended(
        backgroundColor: AppConstants.darkBlue,
        onPressed: () async {
          showDialog(context: context, builder: (context){
            return const AgregarCancha();
          });
        }, label: const Text('Añadir cancha', style: TextStyle(color: Colors.white),),
        icon: const Icon(Icons.add, color: Colors.white,),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FutureBuilder(
              future: FirebaseFirestore.instance.collection('canchas').doc('cancha de ${user!.email}').get(),
              builder: (context, snapshot){
                if (snapshot.connectionState == ConnectionState.done) {
                  if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  }
                  if (snapshot.hasData) {
                    final userDoc = snapshot.data!;
                    final cancha = userDoc['cancha'] as String?;
                    final disponible = userDoc['disponible'] as bool?;
                    final techada = userDoc['techada'] as bool?;

                    return Column(
                      children: [
                        Text(cancha!),
                        Text(techada != null ? 'Si':'No'),
                        Text(disponible != null ? 'Disponible':'No disponible'),
                      ],
                    );
                  }
                }
                return const CircularProgressIndicator();
              }
              ),
        ],
      ),
    );
  }
}
