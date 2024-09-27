import 'package:agendado_admin/appConstantes.dart';
import 'package:agendado_admin/widgets/webBento.dart';
import 'package:flutter/material.dart';

class DashBoard extends StatelessWidget {
  const DashBoard({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
            children: [
              WebBento(titulo: 'MIS CANCHAS', icon: Icons.sports_tennis_rounded, nro: 4, color: AppConstants.darkBlue,),
              WebBento(titulo: 'CANCHAS DISP.', icon: Icons.event_available_rounded, nro: 2, color: Colors.green,),
              WebBento(titulo: 'RESERVAS', icon: Icons.person_2_rounded, nro: 2, color: Color.fromRGBO(189, 168, 5, 1),),
            ]
        ),
        SizedBox(height: 10,),
        Row(
          children: [
            WebBento(titulo: 'CANCELACIONES', icon: Icons.cancel_outlined, nro: 0, color: Colors.redAccent,),
            WebBento(titulo: 'PENDIENTES', icon: Icons.payments_rounded, nro: 1, color: Colors.orange,),
          ],
        ),
      ],
    );
  }
}