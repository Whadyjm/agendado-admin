import 'package:agendado_admin/appConstantes.dart';
import 'package:agendado_admin/widgets/customButton.dart';
import 'package:flutter/material.dart';

class CanchaWidget extends StatelessWidget {
  const CanchaWidget({super.key, required this.cancha, required this.disponible, required this.techada, required this.horario});

  final String cancha;
  final bool disponible;
  final bool techada;
  final String horario;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 375,
        width: MediaQuery.sizeOf(context).width,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade300,
              blurRadius: 2,
              spreadRadius: 5,
              offset: const Offset(4, 2)
            )
          ]
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 150,
              width: MediaQuery.sizeOf(context).width,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(topLeft: Radius.circular(12), topRight: Radius.circular(12)),
                color: Colors.grey,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(cancha),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(disponible ? 'Disponible':'No disponible'),
                  const SizedBox(width: 10,),
                  Container(
                    height: 10,
                    width: 10,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.green
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(techada ? 'Techada':'No techada'),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(horario),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  CustomButton(
                      height: 40,
                      width: 100,
                      color: AppConstants.darkBlue,
                      radius: 12,
                      text: 'Editar',
                      textColor: Colors.white,
                      shadow: 0,
                      colorShadow: Colors.transparent,
                      fontSize: 15),
                  const SizedBox(width: 10,),
                  CustomButton(
                      height: 40,
                      width: 100,
                      color: Colors.redAccent,
                      radius: 12,
                      text: 'Eliminar',
                      textColor: Colors.white,
                      shadow: 0,
                      colorShadow: Colors.transparent,
                      fontSize: 15),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
