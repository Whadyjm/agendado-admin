import 'package:flutter/material.dart';

class Canchas extends StatelessWidget {
  const Canchas({super.key});

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
              onPressed: (){},
              icon: const Icon(Icons.add_box, size: 100,), color: Colors.grey,)
          ]
        ),
      ],
    );
  }
}
