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

  late DateTime? selectedDate = DateTime.now();
  late TimeOfDay? selectedTime1 = TimeOfDay.now();
  late TimeOfDay? selectedTime2 = TimeOfDay.now();

  Future<void> showDate () async {
    selectedDate = await showDatePicker(
        keyboardType: TextInputType.datetime,
        context: context,
        firstDate: DateTime.now(),
        lastDate: DateTime(2050)
    );
    if (selectedDate != null) {
      setState(() {});
    } else {
      selectedDate = DateTime.now();
    }
  }

  Future<void> pickHour1 () async {
    selectedTime1 = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now()
    );
    if (selectedTime1 != null) {
      setState(() {});
    } else {
      selectedTime1 = TimeOfDay.now();
    }
  }

  Future<void> pickHour2 () async {
    selectedTime2 = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now()
    );
    if (selectedTime2 != null) {
      setState(() {});
    } else {
      selectedTime2 = TimeOfDay.now();
    }
  }

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

  Widget build(BuildContext context) {

    return AlertDialog(
      title: const Center(child: Text('Datos de perfil')),
      content: SizedBox(
        height: 300,
        width: 300,
        child: FutureBuilder(
          future: FirebaseFirestore.instance.collection('users').doc(user!.email).get(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextField(
                  controller: empresaController,
                  decoration: InputDecoration(
                    labelText: userModel!.empresa,
                    prefixIcon: const Icon(Icons.sports_tennis_rounded),
                    border: const OutlineInputBorder(),
                    enabledBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: AppConstants.darkBlue),
                    ),
                    focusedBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.green),
                    ),
                  ),
                ),
                const SizedBox(height: 10,),
                TextField(
                  controller: direccionController,
                  decoration: InputDecoration(
                    labelText: userModel!.direccion,
                    prefixIcon: const Icon(Icons.location_pin),
                    border: const OutlineInputBorder(),
                    enabledBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: AppConstants.darkBlue),
                    ),
                    focusedBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.green),
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: GestureDetector(
                        onTap: pickHour1,
                        child: Container(
                            padding: const EdgeInsets.all(12),
                            height: 50,
                            width: 120,
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.3),
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text('Desde'),
                                Text(userModel!.desde, style: const TextStyle(fontSize: 12, color: Colors.grey),)
                              ],
                            )
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: GestureDetector(
                        onTap: pickHour2,
                        child: Container(
                            padding: const EdgeInsets.all(12),
                            height: 50,
                            width: 120,
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.3),
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text('Hasta'),
                                Text(userModel!.hasta, style: const TextStyle(fontSize: 12, color: Colors.grey),)
                              ],
                            )
                        ),
                      ),
                    ),
                  ],
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

                        // TODO: Terminar con los parametros que faltan por editar y extraer metodo!!!!!
                        try{
                          FirebaseFirestore.instance
                              .collection('users')
                              .doc(user!.email)
                              .update({
                            'empresa': empresaController.text.trim(),
                          });
                        }catch(e){

                        }finally {
                          Navigator.pop(context);
                        }
                      },
                      child: const Text('Guardar cambios', style: TextStyle(color: AppConstants.darkBlue, fontSize: 18, fontWeight: FontWeight.bold),)
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}