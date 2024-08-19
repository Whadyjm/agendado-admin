import 'package:agendado_admin/appConstantes.dart';
import 'package:flutter/material.dart';

class WebBento extends StatelessWidget {
  const WebBento({super.key, required this.titulo, required this.icon, required this.nro, required this.color});

  final String titulo;
  final IconData icon;
  final int nro;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: InkWell(
        child: MaterialButton(
          onPressed: () {  },
          child: Container(
            padding: const EdgeInsets.all(8),
            height: 180,
            width: 500,
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                    color: Colors.grey.shade300,
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
                Text(titulo, style: const TextStyle(color: Colors.white, fontSize: 25, fontWeight: FontWeight.bold, fontStyle: FontStyle.italic),),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Icon(icon, color: Colors.white, size: 30,),
                    const SizedBox(width: 50,),
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Text('$nro', style: const TextStyle(color: Colors.white, fontSize: 70, fontWeight: FontWeight.bold, fontStyle: FontStyle.italic),),
                    ),
                  ],
                ),
              ],
            )
          ),
        ),
      ),
    );
  }
}
