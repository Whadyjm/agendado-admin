import 'package:agendado_admin/appConstantes.dart';
import 'package:flutter/material.dart';

class Bento extends StatelessWidget {
  const Bento({super.key, required this.titulo, required this.icon, required this.nro, required this.color});

  final String titulo;
  final IconData icon;
  final int nro;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        padding: const EdgeInsets.all(8),
        height: 150,
        width: 150,
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade400,
              blurRadius: 5,
              spreadRadius: 5,
              offset: const Offset(2.5, 2.5)
            )
          ],
          borderRadius: BorderRadius.circular(21),
          color: color,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(titulo, style: const TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold, fontStyle: FontStyle.italic),),
            Row(
              children: [
                Icon(icon, color: Colors.white, size: 30,),
                const SizedBox(width: 50,),
                Text('$nro', style: const TextStyle(color: Colors.white, fontSize: 70, fontWeight: FontWeight.bold, fontStyle: FontStyle.italic),),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
