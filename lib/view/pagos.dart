import 'package:agendado_admin/appConstantes.dart';
import 'package:flutter/material.dart';

class Pagos extends StatefulWidget {
  const Pagos({super.key});

  @override
  State<Pagos> createState() => _PagosState();
}

class _PagosState extends State<Pagos> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            height: 800,
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
            child: const Padding(
              padding: EdgeInsets.all(18.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text('Pagos confirmados', style: TextStyle(color: AppConstants.darkBlue, fontWeight: FontWeight.w600, fontSize: 20),),
                  VerticalDivider(),
                  Text('Pagos sin confirmar', style: TextStyle(color: AppConstants.darkBlue, fontWeight: FontWeight.w600, fontSize: 20),),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
