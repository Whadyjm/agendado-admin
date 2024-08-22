import 'package:agendado_admin/widgets/agregarCancha.dart';
import 'package:flutter/material.dart';

class Canchas extends StatefulWidget {
  const Canchas({super.key});

  @override
  State<Canchas> createState() => _CanchasState();
}

class _CanchasState extends State<Canchas> {

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text('Añade tus canchas', style: TextStyle(fontSize: 25, color: Colors.grey),),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              onPressed: (){
                showDialog(context: context, builder: (context){
                  return AgregarCancha();
                });
              },
              icon: const Icon(Icons.add_box, size: 100,), color: Colors.grey,),
          ]
        ),
      ],
    );
  }
}
