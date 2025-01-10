import 'package:agendado_admin/appConstantes.dart';
import 'package:agendado_admin/widgets/customButton.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Password extends StatefulWidget {
  const Password({super.key});

  @override
  State<Password> createState() => _PasswordState();
}

class _PasswordState extends State<Password> {

  TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppConstants.darkBlue,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('Recuperar contraseña', style: TextStyle(color: Colors.white, fontSize: 28),),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: SizedBox(
              width: 500,
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
          MaterialButton(
              height: 60,
              minWidth: 150,
              color: AppConstants.green,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18)
              ),
              onPressed: () async {
                if (emailController.text.isEmpty) {
                  showDialog(context: context, builder: (context) {
                    return const AlertDialog(
                      content: Text('Ingrese su correo electrónico',
                        style: TextStyle(color: AppConstants.darkBlue,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),),
                    );
                  }
                  );
                } else {
                  try {
                    FirebaseAuth.instance.sendPasswordResetEmail(
                        email: emailController.text.trim());
                  } catch (e) {

                  } finally {
                    Navigator.pop(context);
                  }
                }

              },
              child:const Text('Recuperar', style: TextStyle(color: AppConstants.darkBlue, fontSize: 20, fontWeight: FontWeight.bold),)),
        ],
      ),
    );
  }
}
