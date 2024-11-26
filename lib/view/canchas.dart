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

    return Scaffold(
      floatingActionButton:
      FloatingActionButton.extended(
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
          StreamBuilder(
            stream: FirebaseFirestore.instance.collection('canchas').snapshots(),
            builder: (context, snapshot) {
              if(snapshot.connectionState == ConnectionState.waiting){
                return const Center(child: CircularProgressIndicator(),);
              }
              if (!snapshot.hasData){
                return const Text('Sin Canchas');
              }
              return Expanded(
                child: ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index){
                    return Container(
                      child: Column(
                        children: [
                          Text('${snapshot.data!.docs[index].data()['cancha']}'),
                          Text(snapshot.data!.docs[index].data()['techada'] ? 'Si':'No'),
                          Text(snapshot.data!.docs[index].data()['disponible'] ? 'Disponible':'No disponible'),
                          StreamBuilder(
                              stream: FirebaseFirestore.instance.collection('perfiles').snapshots(),
                              builder: (context, snapshot){
                                if(snapshot.connectionState == ConnectionState.waiting){
                                  return const Center(child: CircularProgressIndicator(),);
                                }
                                if (!snapshot.hasData){
                                  return const Text('Sin Info');
                                }
                                return Text('${snapshot.data!.docs[index].data()['horario']}');
                              })
                        ],
                      ),
                    );
                  },
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
