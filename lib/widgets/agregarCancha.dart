import 'dart:convert';

import 'package:agendado_admin/widgets/image_picker_widget.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AgregarCancha extends StatefulWidget {
  const AgregarCancha({super.key});

  @override
  State<AgregarCancha> createState() => _AgregarCanchaState();
}

class _AgregarCanchaState extends State<AgregarCancha> {
  @override
  Widget build(BuildContext context) {

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

    bool yes = false;
    bool no = false;

    return AlertDialog(
      title: const Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Agregar Cancha'),
        ],
      ),
      content: SizedBox(
        height: 500,
        width: 500,
        child: Column(
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
            const SizedBox(
              width: 400,
              child: Padding(
                padding: EdgeInsets.all(15.0),
                child: TextField(
                  decoration: InputDecoration(
                    labelText: 'Nombre de cancha',
                    prefixIcon: Icon(Icons.sports_tennis_rounded),
                    border: OutlineInputBorder(),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.green),
                    ),
                  ),
                ),
              ),
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
                            icon: yes == true ? Icon(Icons.check_box):Icon(Icons.check_box_outline_blank_rounded)
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
                            icon: no == true ? Icon(Icons.check_box):Icon(Icons.check_box_outline_blank_rounded)
                        )
                      ],
                    ),
                  ],
                );
              },

            ),
          ],
        ),
      )
    );
  }
}
