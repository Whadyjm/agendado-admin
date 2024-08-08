import 'package:agendado_admin/widgets/sideMenuItem.dart';
import 'package:flutter/material.dart';

class SideMenu extends StatelessWidget {
  const SideMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.sizeOf(context).height,
      width: 200,
      color: Colors.grey,
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 5,),
          SideMenuItem(prefixIcon: Icons.dashboard_rounded, text: 'Dashboard', suffixIcon: Icons.arrow_forward_ios_rounded,),
          Divider(),
          SideMenuItem(prefixIcon: Icons.sports_tennis_rounded, text: 'Canchas', suffixIcon: Icons.arrow_forward_ios_rounded),
          Divider(),
          SideMenuItem(prefixIcon: Icons.person, text: 'Perfil', suffixIcon: Icons.arrow_forward_ios_rounded),
          Divider(),
          SideMenuItem(prefixIcon: Icons.payments_outlined, text: 'Pagos', suffixIcon: Icons.arrow_forward_ios_rounded),
          Divider(),
        ],
      ),
    );
  }
}
