import 'package:agendado_admin/appConstantes.dart';
import 'package:agendado_admin/providers/canchaProvider.dart';
import 'package:agendado_admin/widgets/agregarCancha.dart';
import 'package:agendado_admin/widgets/canchaWidget.dart';
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

    final canchaProvider = Provider.of<CanchaProvider>(context, listen: false);
    final cancha = canchaProvider.getCanchas.values.toList();
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
        children: [
          SizedBox(
            height: 800,
            width: 500,
            child: ListView.builder(
                itemCount: canchaProvider.getCanchas.length,
                itemBuilder: (context, index){
                  return (user!.uid == canchaProvider.getCanchas.values.toList()[index].userId)
                      ?CanchaWidget(
                    cancha: cancha[index].cancha,
                    disponible: cancha[index].disponible,
                    techada: cancha[index].techada,
                    horario: '',)
                      :const SizedBox.shrink();
            }),
          )
        ],
      ),
    );
  }
}
