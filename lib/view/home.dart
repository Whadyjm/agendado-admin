import 'package:agendado_admin/appConstantes.dart';
import 'package:agendado_admin/authPages/login.dart';
import 'package:agendado_admin/providers/canchaProvider.dart';
import 'package:agendado_admin/view/canchas.dart';
import 'package:agendado_admin/view/pagos.dart';
import 'package:agendado_admin/view/perfil.dart';
import 'package:agendado_admin/view/webPage.dart';
import 'package:agendado_admin/widgets/agregarCancha.dart';
import 'package:agendado_admin/widgets/bento.dart';
import 'package:agendado_admin/view/dashboard.dart';
import 'package:agendado_admin/widgets/sideMenuItem.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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

  final PageController _pageController = PageController();

  Future<void> fetchFCT() async {
    final canchaProvider = Provider.of<CanchaProvider>(context, listen: false);

    try {
      Future.wait({
        canchaProvider.fetchCanchaList()
      });
    } catch (e) {
    }
  }

  @override
  void didChangeDependencies() {

    fetchFCT();
    super.didChangeDependencies();
  }

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
          IconButton(onPressed: (){
            auth.signOut();
            Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context){
              return const WebPage();
            }), (Route<dynamic> route) => false);
          }, icon: const Icon(Icons.logout_rounded, color: Colors.white,))
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
                  _pageController.animateToPage(0, duration: const Duration(milliseconds: 400), curve: Curves.easeIn);
                  setState(() {});
                  active1
                      ? active1 = true
                      : active1 = !active1;
                  active2 = false;
                  active3 = false;
                  active4 = false;
                },
                child: active1
                    ? Container(
                    decoration: BoxDecoration(
                        color: AppConstants.darkBlue,
                      borderRadius: BorderRadius.circular(8),
                    ), child: const SideMenuItem(prefixIcon: Icons.dashboard_rounded, text: 'Dashboard', suffixIcon: Icons.arrow_forward_ios_rounded,))
                    : const SideMenuItem(prefixIcon: Icons.dashboard_rounded, text: 'Dashboard', suffixIcon: Icons.arrow_forward_ios_rounded,)),
            const Divider(),
            MaterialButton(
                onPressed: () {
                  _pageController.animateToPage(1, duration: const Duration(milliseconds: 400), curve: Curves.easeIn);
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
                    decoration: BoxDecoration(
                        color: AppConstants.darkBlue,
                      borderRadius: BorderRadius.circular(8),
                    ),child: const SideMenuItem(prefixIcon: Icons.sports_tennis_rounded, text: 'Canchas', suffixIcon: Icons.arrow_forward_ios_rounded))
                    : const SideMenuItem(prefixIcon: Icons.sports_tennis_rounded, text: 'Canchas', suffixIcon: Icons.arrow_forward_ios_rounded)),
            const Divider(),
            MaterialButton(
                onPressed: (){
                  _pageController.animateToPage(2, duration: const Duration(milliseconds: 400), curve: Curves.easeIn);
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
                    decoration: BoxDecoration(
                      color: AppConstants.darkBlue,
                      borderRadius: BorderRadius.circular(8),
                    ), child: const SideMenuItem(prefixIcon: Icons.person, text: 'Mi Perfil', suffixIcon: Icons.arrow_forward_ios_rounded))
                    : const SideMenuItem(prefixIcon: Icons.person, text: 'Mi Perfil', suffixIcon: Icons.arrow_forward_ios_rounded)),
            const Divider(),
            MaterialButton(
                onPressed: (){
                  _pageController.animateToPage(3, duration: const Duration(milliseconds: 400), curve: Curves.easeIn);
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
                    decoration: BoxDecoration(
                      color: AppConstants.darkBlue,
                      borderRadius: BorderRadius.circular(8),
                    ), child: const SideMenuItem(prefixIcon: Icons.payments_outlined, text: 'Pagos', suffixIcon: Icons.arrow_forward_ios_rounded))
                    : const SideMenuItem(prefixIcon: Icons.payments_outlined, text: 'Pagos', suffixIcon: Icons.arrow_forward_ios_rounded)),
            const Divider(),
          ],
        ),
      ),
            SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: MediaQuery.sizeOf(context).height,
                    width: MediaQuery.of(context).size.width - 200,
                    child: PageView(
                      controller: _pageController,
                      children: const [
                        DashBoard(),
                        Canchas(),
                        Perfil(),
                        Pagos()
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      )
    )
        : Scaffold(
      drawer: Drawer(
        backgroundColor: AppConstants.darkBlue,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 5,),
            MaterialButton(
                onPressed: () {
                  Navigator.pop(context);
                  _pageController.animateToPage(0, duration: const Duration(milliseconds: 400), curve: Curves.easeIn);
                  setState(() {});
                  active1
                      ? active1 = true
                      : active1 = !active1;
                  active2 = false;
                  active3 = false;
                  active4 = false;
                },
                child: active1
                    ? Container(
                    decoration: BoxDecoration(
                      color: Colors.black12,
                      borderRadius: BorderRadius.circular(8),
                    ), child: const SideMenuItem(prefixIcon: Icons.dashboard_rounded, text: 'Dashboard', suffixIcon: Icons.arrow_forward_ios_rounded,))
                    : const SideMenuItem(prefixIcon: Icons.dashboard_rounded, text: 'Dashboard', suffixIcon: Icons.arrow_forward_ios_rounded,)),
            const Divider(),
            MaterialButton(
                onPressed: () {
                  Navigator.pop(context);
                  _pageController.animateToPage(1, duration: const Duration(milliseconds: 400), curve: Curves.easeIn);
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
                    decoration: BoxDecoration(
                      color: Colors.black12,
                      borderRadius: BorderRadius.circular(8),
                    ),child: const SideMenuItem(prefixIcon: Icons.sports_tennis_rounded, text: 'Canchas', suffixIcon: Icons.arrow_forward_ios_rounded))
                    : const SideMenuItem(prefixIcon: Icons.sports_tennis_rounded, text: 'Canchas', suffixIcon: Icons.arrow_forward_ios_rounded)),
            const Divider(),
            MaterialButton(
                onPressed: (){
                  Navigator.pop(context);
                  _pageController.animateToPage(2, duration: const Duration(milliseconds: 400), curve: Curves.easeIn);
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
                    decoration: BoxDecoration(
                      color: Colors.black12,
                      borderRadius: BorderRadius.circular(8),
                    ), child: const SideMenuItem(prefixIcon: Icons.person, text: 'Mi Perfil', suffixIcon: Icons.arrow_forward_ios_rounded))
                    : const SideMenuItem(prefixIcon: Icons.person, text: 'Mi Perfil', suffixIcon: Icons.arrow_forward_ios_rounded)),
            const Divider(),
            MaterialButton(
                onPressed: (){
                  Navigator.pop(context);
                  _pageController.animateToPage(3, duration: const Duration(milliseconds: 400), curve: Curves.easeIn);
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
                    decoration: BoxDecoration(
                      color: Colors.black12,
                      borderRadius: BorderRadius.circular(8),
                    ), child: const SideMenuItem(prefixIcon: Icons.payments_outlined, text: 'Pagos', suffixIcon: Icons.arrow_forward_ios_rounded))
                    : const SideMenuItem(prefixIcon: Icons.payments_outlined, text: 'Pagos', suffixIcon: Icons.arrow_forward_ios_rounded)),
            const Divider(),
            MaterialButton(
                onPressed: (){
                  auth.signOut();
                  Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context){
                    return const Login();
                  }), (route) => false);
                },
                child: const SideMenuItem(prefixIcon: Icons.logout_rounded, text: 'Cerrar sesión', suffixIcon: Icons.arrow_forward_ios_rounded)),
          ],
        ),
      ),
      appBar: AppBar(
        backgroundColor: AppConstants.darkBlue,
        elevation: 5,
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(onPressed: (){
            Scaffold.of(context).openDrawer();
          }, icon: const Icon(Icons.menu_rounded, color: Colors.white,));
            },
        ),
        // title: Text(user!.email ?? '', style: const TextStyle(fontSize: 18, color: Colors.white),),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.sizeOf(context).height,
              width: MediaQuery.of(context).size.width,
              child: PageView(
                controller: _pageController,
                children: [
                  const DashBoard(),
                  const Canchas(),
                  Visibility(
                      visible: user == null ? false:true,
                      child: const Perfil()),
                  const Pagos()
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
