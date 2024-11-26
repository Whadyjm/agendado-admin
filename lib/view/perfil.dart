import 'package:agendado_admin/appConstantes.dart';
import 'package:agendado_admin/models/userModel.dart';
import 'package:agendado_admin/providers/userProvider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Perfil extends StatefulWidget {
  const Perfil({super.key});

  @override
  State<Perfil> createState() => _PerfilState();
}

class _PerfilState extends State<Perfil> {

  UserModel? userModel;
  User? user = FirebaseAuth.instance.currentUser;

  Future<void> fetchUserInfo() async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    try {
      userModel = await userProvider.fetchUserInfo();
    } finally {
    }
  }

  @override
  void initState() {
    fetchUserInfo();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    final screenSize = MediaQuery.sizeOf(context).width > 600;

    return screenSize
        ? Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 400,
            width: MediaQuery.sizeOf(context).width - 100,
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                    color: Colors.grey.shade300,
                    blurRadius: 5,
                    spreadRadius: 5,
                    offset: const Offset(2.5, 2.5)
                )
              ],
              borderRadius: BorderRadius.circular(21),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                const SizedBox(height: 10,),
                TextButton(onPressed: (){}, child: const Text('Editar', style: TextStyle(fontSize: 15),)),
                const Row(
                  children: [
                    const SizedBox(width: 50,),
                    Padding(
                      padding: EdgeInsets.all(12.0),
                      child: CircleAvatar(
                        backgroundColor: Colors.grey,
                        radius: 80,
                        child: Icon(Icons.image, color: Colors.white38,),
                      ),
                    ),
                    const SizedBox(width: 40,),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Empresa', style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold, fontSize: 15),),
                        Text('Padel Park', style: TextStyle(color: AppConstants.darkBlue, fontWeight: FontWeight.w600, fontSize: 20),),
                      ],
                    ),
                    const SizedBox(width: 40,),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Dirección', style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold, fontSize: 15),),
                        Text('Urb. El Trigal, Calle Nro 130', style: TextStyle(color: AppConstants.darkBlue, fontWeight: FontWeight.w600, fontSize: 20),),
                      ],
                    ),
                    const SizedBox(width: 40,),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Horario', style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold, fontSize: 15),),
                        Text('8:00 am - 10:00 pm', style: TextStyle(color: AppConstants.darkBlue, fontWeight: FontWeight.w600, fontSize: 20),),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    )
        : Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: MediaQuery.sizeOf(context).width,
            width: 500,
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                    color: Colors.grey.shade300,
                    blurRadius: 5,
                    spreadRadius: 5,
                    offset: const Offset(2.5, 2.5)
                )
              ],
              borderRadius: BorderRadius.circular(21),
            ),
            child: Column(
              children: [
                const SizedBox(height: 10,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(onPressed: () async {
                      await showDialog(context: context, builder: (context) {
                        return const editarDatos();
                      }
                      );
                    }, child: const Text('Editar', style: TextStyle(fontSize: 15),)),
                  ],
                ),
                FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
                  future: FirebaseFirestore.instance.collection('users').doc('martinez.whady@gmail.com').get(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      if (snapshot.hasError) {
                        return Text('Error: ${snapshot.error}');
                      }

                      if (snapshot.hasData) {
                        final userDoc = snapshot.data!;
                        final empresa = userDoc['empresa'] as String?;
                        final rif = userDoc['rif'] as String?;
                        final direccion = userDoc['direccion'] as String?;
                        final desde = userDoc['desde'] as String?;
                        final hasta = userDoc['hasta'] as String?;

                        return Column(
                          children: [
                            const Padding(
                              padding: EdgeInsets.all(12.0),
                              child: CircleAvatar(
                                backgroundColor: Colors.grey,
                                radius: 80,
                                child: Icon(Icons.image, color: Colors.white38,),
                              ),
                            ),
                            const Text('Empresa', style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold, fontSize: 15),),
                            Text('$empresa', style: const TextStyle(color: AppConstants.darkBlue, fontWeight: FontWeight.w600, fontSize: 20),),
                            const Text('RIF', style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold, fontSize: 15),),
                            Text('J-$rif', style: const TextStyle(color: AppConstants.darkBlue, fontWeight: FontWeight.w600, fontSize: 20),),
                            const Text('Dirección', style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold, fontSize: 15),),
                            Text('$direccion', style: const TextStyle(color: AppConstants.darkBlue, fontWeight: FontWeight.w600, fontSize: 20),),
                            const Text('Horario', style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold, fontSize: 15),),
                            Text('$desde:00 - $hasta:00', style: const TextStyle(color: AppConstants.darkBlue, fontWeight: FontWeight.w600, fontSize: 20),),
                          ],
                        );
                      }
                    }

                    return const CircularProgressIndicator();
                  },
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class editarDatos extends StatefulWidget {
  const editarDatos({
    super.key,
  });

  @override
  State<editarDatos> createState() => _editarDatosState();
}

class _editarDatosState extends State<editarDatos> {
  @override

  bool _isButtonEnabled = false;

  TextEditingController empresaController = TextEditingController();
  TextEditingController direccionController = TextEditingController();

  Widget build(BuildContext context) {

    return AlertDialog(
      title: const Center(child: Text('Datos de perfil')),
      content: SizedBox(
        height: 200,
        width: 150,
        child: Column(
          children: [
          TextField(
          controller: empresaController,
          onChanged: (value){
            setState(() {
              _isButtonEnabled = value.isEmpty;
            });
          },
          decoration: const InputDecoration(
            labelText: 'Empresa',
            prefixIcon: Icon(Icons.sports_tennis_rounded),
            border: OutlineInputBorder(),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: AppConstants.darkBlue),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.green),
            ),
          ),
        ),
            const SizedBox(height: 10,),
            TextField(
              controller: direccionController,
              onChanged: (value){
                setState(() {
                  _isButtonEnabled = value.isEmpty;
                });
              },
              decoration: const InputDecoration(
                labelText: 'Direccion',
                prefixIcon: Icon(Icons.location_pin),
                border: OutlineInputBorder(),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: AppConstants.darkBlue),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.green),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: MaterialButton(
                  height: 60,
                  minWidth: 350,
                  color: AppConstants.green,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18)
                  ),
                  onPressed: () async {
                  },
                  child: const Text('Guardar cambios', style: TextStyle(color: AppConstants.darkBlue, fontSize: 18, fontWeight: FontWeight.bold),)
              ),
            ),
          ],
        ),
      ),
    );
  }
}