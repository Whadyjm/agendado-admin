import 'package:agendado_admin/appConstantes.dart';
import 'package:flutter/material.dart';

class Perfil extends StatefulWidget {
  const Perfil({super.key});

  @override
  State<Perfil> createState() => _PerfilState();
}

class _PerfilState extends State<Perfil> {
  @override
  Widget build(BuildContext context) {
    return Padding(
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
    );
  }
}
