import 'package:agendado_admin/appConstantes.dart';
import 'package:flutter/material.dart';

class WebPage extends StatefulWidget {
  const WebPage({super.key});

  @override
  State<WebPage> createState() => _WebPageState();
}

class _WebPageState extends State<WebPage> {

  bool visible = true;

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppConstants.darkBlue,
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 150,),
            Image.asset(height: 200, 'assets/agendado_logo.png'),
            const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Admin', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontStyle: FontStyle.italic, fontSize: 30),),
              ],
            ),
            const SizedBox(height: 50,),
            SizedBox(
              height: 100,
              width: 500,
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: TextFormField(
                    controller: emailController,
                    keyboardType: TextInputType.emailAddress,
                    cursorColor: AppConstants.green,
                    style: const TextStyle(color: AppConstants.green),
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.mail_outline_rounded, color: AppConstants.green),
                      labelText: 'Correo eletrónico',
                      labelStyle: const TextStyle(color: Colors.grey),
                      filled: true,
                      floatingLabelBehavior: FloatingLabelBehavior.never,
                      fillColor: Colors.white.withOpacity(0.3),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: const BorderSide(width: 0, style: BorderStyle.none),
                      ),
                    ),
                    validator: (value){
                      if(value!.isEmpty || !value.contains('@')){
                        return "Ingrese un correo electrónico válido";
                      }else{
                        null;
                      }
                    }
                ),
              ),
            ),
            SizedBox(
              height: 100,
              width: 500,
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: TextFormField(
                    keyboardType: TextInputType.text,
                    controller: passwordController,
                    obscureText: visible,
                    //enableSuggestions: !isPasswordType,
                    cursorColor: AppConstants.green,
                    style: const TextStyle(color: AppConstants.green),
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.lock_outline_rounded, color: AppConstants.green),
                      suffixIcon: IconButton(
                          highlightColor: Colors.transparent,
                          onPressed: (){
                            setState(() {visible = !visible;});
                          },
                          icon: Icon(visible == true ? Icons.visibility:Icons.visibility_off_rounded), color: Colors.grey),
                      labelText: 'Contraseña',
                      labelStyle: const TextStyle(color: Colors.grey),
                      filled: true,
                      floatingLabelBehavior: FloatingLabelBehavior.never,
                      fillColor: Colors.white.withOpacity(0.3),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: const BorderSide(width: 0, style: BorderStyle.none),
                      ),
                    ),
                    validator: (value){
                      if(value!.isEmpty){
                        return "Ingrese una contraseña";
                      }else{
                        null;
                      }
                    }
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Checkbox(
                    value: true,
                    onChanged: (value){},
                    activeColor: AppConstants.green,),
                  GestureDetector(
                      child: const Text('Recordar contraseña', style: TextStyle(fontSize: 15, color: AppConstants.green, fontWeight: FontWeight.w600),)),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(onPressed: (){}, child: const Text('¿Olvidaste tu contraseña?', style: TextStyle(fontSize: 15, color: AppConstants.green),),),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: MaterialButton(
                  height: 60,
                  minWidth: 350,
                  color: AppConstants.green,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18)
                  ),
                  onPressed: (){
                    // Navigator.push(context, MaterialPageRoute(builder: (context){
                    //   return const Home();
                    // }));
                  },
                  child: const Text('Iniciar sesión', style: TextStyle(color: AppConstants.darkBlue, fontSize: 20, fontWeight: FontWeight.bold),)
              ),
            ),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.center,
            //   children: [
            //     const Text('¿Aun no tienes cuenta?', style: TextStyle(fontSize: 18, color: AppConstants.green),),
            //     GestureDetector(
            //         onTap: (){
            //         },
            //         child:
            //         TextButton(onPressed: () {
            //           // Navigator.push(context, MaterialPageRoute(builder: (context){
            //           //   return const Registro();
            //           // }));
            //         }, child: const Text('Regístrate', style: TextStyle(fontSize: 17, color: Colors.white, fontWeight: FontWeight.w600),))),
            //   ],
            // ),
          ],
        ),
      ),
    );
  }
}
