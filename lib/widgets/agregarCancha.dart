import 'dart:convert';

import 'package:agendado_admin/appConstantes.dart';
import 'package:agendado_admin/widgets/customButton.dart';
import 'package:agendado_admin/widgets/image_picker_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AgregarCancha extends StatefulWidget {
  const AgregarCancha({super.key});

  @override
  State<AgregarCancha> createState() => _AgregarCanchaState();
}

class _AgregarCanchaState extends State<AgregarCancha> {

  XFile? _pickedImage;

  String base64String = '';
  Future<void> galeriaPicker() async {
    final ImagePicker imagePicker = ImagePicker();
    _pickedImage = await imagePicker.pickImage(source: ImageSource.gallery);
    Uint8List _bytes = await _pickedImage!.readAsBytes();

    String _base64String = base64.encode(_bytes);
    setState(() {base64String = _base64String;});
  }

  void pickImage() async {
    await showDialog(context: context, builder: (context){
      return AlertDialog(
        title: const Center(child: Text('Elije una opción')),
        content: SizedBox(
          height: 170,
          width: 150,
          child: Column(
            children: [
              const SizedBox(height: 5,),
              TextButton.icon(
                onPressed: (){
                  galeriaPicker();
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.image, color: Colors.deepPurple, size: 30,),
                label: const Text('Galería', style: TextStyle(fontSize: 18),),
              ),
              const SizedBox(height: 5,),
              TextButton.icon(
                onPressed: (){
                  _pickedImage = null;
                  setState(() {});
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.clear, color: Colors.redAccent, size: 30,),
                label: const Text('Eliminar', style: TextStyle(fontSize: 18),),
              ),
            ],
          ),
        ),
      );
    });
  }

  Future<void> agregarCanchaDb() async {

    User? user = FirebaseAuth.instance.currentUser;

    if (_pickedImage == null) {
      aviso1();
    } else if (nombreController.text.isEmpty){
      aviso2();
    } else if ((yes||no)==false){
      aviso3();
    } else {
      try {
        await FirebaseFirestore.instance.collection('canchas')
            .doc('cancha de ${user!.email}')
            .set({
          'cancha': nombreController.text,
          'techada': techoYes ? true:false,
          'disponible': yes ? true:false,
        },
        SetOptions(merge: false));
      } catch (e) {

      } finally {
        Navigator.pop(context);
      }
    }
  }

  bool _isButtonEnabled = false;
  bool yes = false;
  bool no = false;

  bool techoYes = false;
  bool techoNo = false;

  final nombreController = TextEditingController();

  FirebaseFirestore firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {

    return AlertDialog(
      title: const Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Agregar Cancha'),
        ],
      ),
      content: SizedBox(
        height: 650,
        width: 500,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(
                  height: 300,
                  width: 300,
                  child: ImagePickerWidget(
                    imagedPicked: _pickedImage,
                    function: (){
                      galeriaPicker();
                    },)),
              const SizedBox(height: 10,),
              SizedBox(
                width: 400,
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: StatefulBuilder(
                    builder: (BuildContext context, void Function(void Function()) setState) {
                      return TextField(
                        controller: nombreController,
                        onChanged: (value){
                          setState(() {
                            _isButtonEnabled = value.isEmpty;
                          });
                        },
                        decoration: const InputDecoration(
                          labelText: 'Nombre de cancha',
                          prefixIcon: Icon(Icons.sports_tennis_rounded),
                          border: OutlineInputBorder(),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: AppConstants.darkBlue),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.green),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
              const SizedBox(height: 10,),
              const Text('¿Es cancha techada?'),
              const SizedBox(height: 10,),
              StatefulBuilder(
                builder: (BuildContext context, void Function(void Function()) setState) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Row(
                        children: [
                          const Text('Sí'),
                          IconButton(onPressed: (){
                            setState((){});
                            techoYes = true;
                            techoNo = false;
                          },
                              icon: techoYes == true ? const Icon(Icons.check_box, color: Colors.green,):const Icon(Icons.check_box_outline_blank_rounded, color: AppConstants.darkBlue,)
                          )
                        ],
                      ),
                      Row(
                        children: [
                          const Text('No'),
                          IconButton(onPressed: (){
                            setState((){});
                            techoYes = false;
                            techoNo = true;
                          },
                              icon: techoNo == true ? const Icon(Icons.check_box, color: Colors.green,):const Icon(Icons.check_box_outline_blank_rounded, color: AppConstants.darkBlue,)
                          )
                        ],
                      ),
                    ],
                  );
                },
              ),
              const SizedBox(height: 10,),
              const Text('¿Se encuentra actualmente disponible al público?'),
              const SizedBox(height: 10,),
              StatefulBuilder(
                builder: (BuildContext context, void Function(void Function()) setState) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Row(
                        children: [
                          const Text('Sí'),
                          IconButton(onPressed: (){
                            setState((){});
                            yes = true;
                            no = false;
                          },
                              icon: yes == true ? const Icon(Icons.check_box, color: Colors.green,):const Icon(Icons.check_box_outline_blank_rounded, color: AppConstants.darkBlue,)
                          )
                        ],
                      ),
                      Row(
                        children: [
                          const Text('No'),
                          IconButton(onPressed: (){
                            setState((){});
                            yes = false;
                            no = true;
                          },
                              icon: no == true ? const Icon(Icons.check_box, color: Colors.green,):const Icon(Icons.check_box_outline_blank_rounded, color: AppConstants.darkBlue,)
                          )
                        ],
                      ),
                    ],
                  );
                },
              ),
              const SizedBox(height: 10,),
              MaterialButton(
                  height: 60,
                  minWidth: 350,
                  color: AppConstants.green,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18)
                  ),
                  onPressed: () async {
                    agregarCanchaDb();
                    },
                  child: const Text('Agregar cancha', style: TextStyle(color: AppConstants.darkBlue, fontSize: 20, fontWeight: FontWeight.bold),)
              ),
            ],
          ),
        ),
      )
    );
  }

  void aviso2() {
    showDialog(context: context, builder: (context){
      return const AlertDialog(
        title: Row(
          children: [
            Icon(Icons.warning_rounded, color: Colors.amber,),
            const SizedBox(width: 10,),
            Text('Aviso'),
          ],
        ),
        content: Text('Asegúrate de elegir un nombre'),
      );
    });
  }

  void aviso1() {
    showDialog(context: context, builder: (context){
      return const AlertDialog(
        title: Row(
          children: [
            Icon(Icons.warning_rounded, color: Colors.amber,),
            SizedBox(width: 10,),
            Text('Aviso'),
          ],
        ),
        content: Text('Asegúrate de elegir una imagen'),
      );
    });
  }


  void aviso3() {
    showDialog(context: context, builder: (context){
      return const AlertDialog(
        title: Row(
          children: [
            Icon(Icons.warning_rounded, color: Colors.amber,),
            SizedBox(width: 10,),
            Text('Aviso'),
          ],
        ),
        content: Text('Elige una opción'),
      );
    });
  }

}
