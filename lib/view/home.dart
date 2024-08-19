import 'package:agendado_admin/appConstantes.dart';
import 'package:agendado_admin/authPages/login.dart';
import 'package:agendado_admin/view/canchas.dart';
import 'package:agendado_admin/widgets/bento.dart';
import 'package:agendado_admin/view/dashboard.dart';
import 'package:agendado_admin/widgets/sideMenuItem.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  bool active1 = true;
  bool active2 = false;
  bool active3 = false;
  bool active4 = false;

  @override
  Widget build(BuildContext context) {

    // FirebaseAuth auth = FirebaseAuth.instance;
    // User? user = FirebaseAuth.instance.currentUser;
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
        actions: const [
          // Padding(
          //   padding: const EdgeInsets.all(8.0),
          //   child: Text(user!.email ?? '', style: const TextStyle(fontSize: 18, color: Colors.white),),
          // ),
          CircleAvatar()
        ],
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
        Container(
        height: MediaQuery.sizeOf(context).height,
        width: 200,
        color: Colors.grey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 5,),
            MaterialButton(
                onPressed: () {
                  setState(() {});
                  active1
                      ? active1 = true
                      : active1 = !active1;
                  active2 = false;
                  active3 = false;

                },
                child: active1
                    ? Container(
                    decoration: const BoxDecoration(
                        color: AppConstants.darkBlue
                    ), child: const SideMenuItem(prefixIcon: Icons.dashboard_rounded, text: 'Dashboard', suffixIcon: Icons.arrow_forward_ios_rounded,))
                    : const SideMenuItem(prefixIcon: Icons.dashboard_rounded, text: 'Dashboard', suffixIcon: Icons.arrow_forward_ios_rounded,)),
            const Divider(),
            MaterialButton(
                onPressed: () {
                  setState(() {
                    active2
                        ? active2 = true
                        : active2 = !active2;
                    active1 = false;
                    active3 = false;
                    active4 = false;
                  });
                },
                child: active2
                    ? Container(
                    decoration: const BoxDecoration(
                        color: AppConstants.darkBlue
                    ),child: const SideMenuItem(prefixIcon: Icons.sports_tennis_rounded, text: 'Canchas', suffixIcon: Icons.arrow_forward_ios_rounded))
                    : const SideMenuItem(prefixIcon: Icons.sports_tennis_rounded, text: 'Canchas', suffixIcon: Icons.arrow_forward_ios_rounded)),
            const Divider(),
            MaterialButton(
                onPressed: (){
                  setState(() {
                    active3
                        ? active3 = true
                        : active3 = !active3;
                    active1 = false;
                    active2 = false;
                    active4 = false;
                  });
                },
                child: active3
                    ? Container(
                    decoration: const BoxDecoration(
                      color: AppConstants.darkBlue,
                    ), child: const SideMenuItem(prefixIcon: Icons.person, text: 'Mi Perfil', suffixIcon: Icons.arrow_forward_ios_rounded))
                    : const SideMenuItem(prefixIcon: Icons.person, text: 'Mi Perfil', suffixIcon: Icons.arrow_forward_ios_rounded)),
            const Divider(),
            MaterialButton(
                onPressed: (){
                  setState(() {
                    active4
                        ? active4 = true
                        : active4 = !active4;
                    active1 = false;
                    active2 = false;
                    active3 = false;
                  });
                },
                child: active4
                    ? Container(
                    decoration: const BoxDecoration(
                      color: AppConstants.darkBlue,
                    ), child: const SideMenuItem(prefixIcon: Icons.payments_outlined, text: 'Pagos', suffixIcon: Icons.arrow_forward_ios_rounded))
                    : const SideMenuItem(prefixIcon: Icons.payments_outlined, text: 'Pagos', suffixIcon: Icons.arrow_forward_ios_rounded)),
            const Divider(),
          ],
        ),
      ),
            if (active1)
              const DashBoard(),
            const SizedBox(width: 750,),
            if (active2)
              const Canchas()
          ],
        ),
      )
    )
        : Scaffold(
      appBar: AppBar(
        backgroundColor: AppConstants.darkBlue,
        elevation: 5,
        leading: IconButton(onPressed: (){}, icon: const Icon(Icons.menu_rounded, color: Colors.white,)),
        // title: Text(user!.email ?? '', style: const TextStyle(fontSize: 18, color: Colors.white),),
        centerTitle: true,
        actions: [
          IconButton(onPressed: (){}, icon: const Icon(Icons.info_outline_rounded, color: Colors.white,)),
          IconButton(onPressed: (){
            // auth.signOut();
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
