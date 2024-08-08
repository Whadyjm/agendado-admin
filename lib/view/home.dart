import 'package:agendado_admin/appConstantes.dart';
import 'package:agendado_admin/authPages/login.dart';
import 'package:agendado_admin/widgets/bento.dart';
import 'package:agendado_admin/widgets/sideMenu.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {

    FirebaseAuth auth = FirebaseAuth.instance;
    User? user = FirebaseAuth.instance.currentUser;
    final screenSize = MediaQuery.sizeOf(context).width > 600;

    return screenSize
        ? Scaffold(
      appBar: AppBar(
        backgroundColor: AppConstants.darkBlue,
        elevation: 5,
        title: Row(
          children: [
            Image.asset(height: 50, 'assets/agendado_logo.png'),
            const Text('Admin', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontStyle: FontStyle.italic, fontSize: 20)),
          ],
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(user!.email ?? '', style: const TextStyle(fontSize: 18, color: Colors.white),),
          ),
        ],
      ),
      body: const Row(
        children: [
          SideMenu(),
        ],
      )
      //const Column(
      //   children: [
      //     const SizedBox(height: 10,),
      //     Row(
      //       mainAxisAlignment: MainAxisAlignment.center,
      //       children: [
      //         Bento(titulo: 'MIS CANCHAS', icon: Icons.sports_tennis_rounded, nro: 4, color: AppConstants.darkBlue,),
      //         Bento(titulo: 'CANCHAS DISP.', icon: Icons.event_available_rounded, nro: 2, color: Colors.green,),
      //         Bento(titulo: 'RESERVAS', icon: Icons.person_2_rounded, nro: 2, color: Color.fromRGBO(189, 168, 5, 1),),
      //       ],
      //     ),
      //     const SizedBox(height: 10,),
      //     Row(
      //       mainAxisAlignment: MainAxisAlignment.start,
      //       children: [
      //         Bento(titulo: 'CANCELACIONES', icon: Icons.cancel_outlined, nro: 0, color: Colors.redAccent,),
      //         Bento(titulo: 'PENDIENTES', icon: Icons.payments_rounded, nro: 1, color: Colors.orange,),
      //       ],
      //     ),
      //   ],
      // ),
    )
        : Scaffold(
      appBar: AppBar(
        backgroundColor: AppConstants.darkBlue,
        elevation: 5,
        leading: IconButton(onPressed: (){}, icon: const Icon(Icons.menu_rounded, color: Colors.white,)),
        title: Text(user!.email ?? '', style: const TextStyle(fontSize: 18, color: Colors.white),),
        centerTitle: true,
        actions: [
          IconButton(onPressed: (){}, icon: const Icon(Icons.info_outline_rounded, color: Colors.white,)),
          IconButton(onPressed: (){
            auth.signOut();
            Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context){
              return const Login();
            }), (route) => false);
          }, icon: const Icon(Icons.logout_rounded, color: Colors.white,)),
        ],
      ),
      body: const Column(
        children: [
          const SizedBox(height: 10,),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Bento(titulo: 'MIS CANCHAS', icon: Icons.sports_tennis_rounded, nro: 4, color: AppConstants.darkBlue,),
              Bento(titulo: 'CANCHAS DISP.', icon: Icons.event_available_rounded, nro: 2, color: Colors.green,),
              Bento(titulo: 'RESERVAS', icon: Icons.person_2_rounded, nro: 2, color: Color.fromRGBO(189, 168, 5, 1),),
            ],
          ),
          const SizedBox(height: 10,),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Bento(titulo: 'CANCELACIONES', icon: Icons.cancel_outlined, nro: 0, color: Colors.redAccent,),
              Bento(titulo: 'PENDIENTES', icon: Icons.payments_rounded, nro: 1, color: Colors.orange,),
            ],
          ),
        ],
      ),
    );
  }
}
