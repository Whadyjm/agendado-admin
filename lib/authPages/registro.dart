import 'package:agendado_admin/appConstantes.dart';
import 'package:agendado_admin/authPages/login.dart';
import 'package:agendado_admin/view/home.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Registro extends StatefulWidget {
  const Registro({super.key});

  @override
  State<Registro> createState() => LoginState();
}

class LoginState extends State<Registro> {

  bool visible = true;
  var empresaTextController = TextEditingController();
  var rifTextController = TextEditingController();
  var phoneTextController = TextEditingController();
  var locationTextController = TextEditingController();
  var emailTextController = TextEditingController();
  var passwordTextController = TextEditingController();
  var confirmPasswordTextController = TextEditingController();

  late DateTime? selectedDate = DateTime.now();
  late TimeOfDay? selectedTime1 = TimeOfDay.now();
  late TimeOfDay? selectedTime2 = TimeOfDay.now();

  Future<void> showDate () async {
    selectedDate = await showDatePicker(
        keyboardType: TextInputType.datetime,
        context: context,
        firstDate: DateTime.now(),
        lastDate: DateTime(2050)
    );
    if (selectedDate != null) {
      setState(() {});
    } else {
      selectedDate = DateTime.now();
    }
  }

  Future<void> pickHour1 () async {
    selectedTime1 = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now()
    );
    if (selectedTime1 != null) {
      setState(() {});
    } else {
      selectedTime1 = TimeOfDay.now();
    }
  }

  Future<void> pickHour2 () async {
    selectedTime2 = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now()
    );
    if (selectedTime2 != null) {
      setState(() {});
    } else {
      selectedTime2 = TimeOfDay.now();
    }
  }

  @override
  Widget build(BuildContext context) {

    final screenPage = MediaQuery.sizeOf(context).width > 600;

    return screenPage
        ? Scaffold(
        backgroundColor: AppConstants.darkBlue,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: MaterialButton(
                          onPressed: () {  },
                          child: GestureDetector(
                              onTap: (){
                                Navigator.pop(context);
                              } ,
                              child: Container(
                                  width: 50,
                                  height: 50,
                                  decoration: BoxDecoration(
                                    color: AppConstants.green,
                                    borderRadius: BorderRadius.circular(18),
                                  ),
                                  child: const Icon(Icons.arrow_back_rounded, color: AppConstants.darkBlue,))
                          ),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(50.0),
                    child: Image.asset(
                        height: 150,
                        'assets/agendado_logo.png'),

                  ),
                  //NOMBRE Y APELLIDO
                  SizedBox(
                    width: 600,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                          controller: empresaTextController,
                          //enableSuggestions: !isPasswordType,
                          cursorColor: AppConstants.green,
                          style: const TextStyle(color: AppConstants.green),
                          decoration: InputDecoration(
                            prefixIcon: const Icon(Icons.perm_identity_rounded, color: AppConstants.green,),
                            labelText: 'Nombre y apellido',
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
                              return "Ingrese su nombre y apellido";
                            }else{
                              null;
                            }
                          }
                      ),
                    ),
                  ),
                  //CORREO ELECTRONICO
                  SizedBox(
                    width: 600,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                          controller: emailTextController,
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
                  //Teléfono
                  SizedBox(
                    width: 600,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                          controller: phoneTextController,
                          keyboardType: TextInputType.number,
                          cursorColor: AppConstants.green,
                          style: const TextStyle(color: AppConstants.green),
                          decoration: InputDecoration(
                            prefixIcon: const Icon(Icons.phone_android_rounded, color: AppConstants.green,),
                            labelText: 'Teléfono',
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
                              return "Ingrese un número de teléfono";
                            }else{
                              null;
                            }
                          }
                      ),
                    ),
                  ),
                  //CONTRASEÑA
                  SizedBox(
                    width: 600,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                          keyboardType: TextInputType.text,
                          controller: passwordTextController,
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
                  SizedBox(
                    width: 600,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                          keyboardType: TextInputType.text,
                          controller: confirmPasswordTextController,
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
                              icon: Icon(visible == true ? Icons.visibility:Icons.visibility_off_rounded), color: Colors.grey,),
                            labelText: 'Confirmar contraseña',
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
                  //REGISTRAR
                  SizedBox(
                    width: 300,
                    child: Padding(
                      padding: const EdgeInsets.all(18.0),
                      child: MaterialButton(
                          height: 60,
                          minWidth: 350,
                          color: AppConstants.green,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18)
                          ),
                          onPressed: (){

                          },
                          child: const Text('Registrarme', style: TextStyle(color: AppConstants.darkBlue, fontSize: 20, fontWeight: FontWeight.bold),)
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('Ya tengo cuenta', style: TextStyle(fontSize: 15, color: Colors.white)),
                      TextButton(onPressed: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context){
                          return Login();
                        }));
                      }, child: const Text('Iniciar sesión', style: TextStyle(fontSize: 17, color: AppConstants.green),))
                    ],
                  )
                ],
              ),
            ),
          ),
        )
    )
        : Scaffold(
        backgroundColor: AppConstants.darkBlue,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: MaterialButton(
                        onPressed: () {  },
                        child: GestureDetector(
                            onTap: (){
                              Navigator.pop(context);
                            } ,
                            child: Container(
                                width: 50,
                                height: 50,
                                decoration: BoxDecoration(
                                  color: AppConstants.green,
                                  borderRadius: BorderRadius.circular(18),
                                ),
                                child: const Icon(Icons.arrow_back_rounded, color: AppConstants.darkBlue,))
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(50.0),
                  child: Image.asset(
                      height: 130,
                      'assets/agendado_logo.png'),
                ),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text('Admin', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontStyle: FontStyle.italic, fontSize: 50),),
                  ],
                ),
                //NOMBRE Y APELLIDO
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                      controller: empresaTextController,
                      //enableSuggestions: !isPasswordType,
                      cursorColor: AppConstants.green,
                      style: const TextStyle(color: AppConstants.green),
                      decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.perm_identity_rounded, color: AppConstants.green,),
                        labelText: 'Empresa',
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
                          return "Ingrese el nombre de la empresa";
                        }else{
                          null;
                        }
                      }
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                      controller: rifTextController,
                      //enableSuggestions: !isPasswordType,
                      cursorColor: AppConstants.green,
                      style: const TextStyle(color: AppConstants.green),
                      decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.numbers_rounded, color: AppConstants.green,),
                        labelText: 'RIF',
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
                          return "Ingrese el RIF de su empresa";
                        }else{
                          null;
                        }
                      }
                  ),
                ),
                //CORREO ELECTRONICO
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                      controller: emailTextController,
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
                //Teléfono
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                      controller: phoneTextController,
                      keyboardType: TextInputType.number,
                      cursorColor: AppConstants.green,
                      style: const TextStyle(color: AppConstants.green),
                      decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.phone_android_rounded, color: AppConstants.green,),
                        labelText: 'Teléfono',
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
                          return "Ingrese un número de teléfono";
                        }else{
                          null;
                        }
                      }
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                      controller: locationTextController,
                      keyboardType: TextInputType.number,
                      cursorColor: AppConstants.green,
                      style: const TextStyle(color: AppConstants.green),
                      decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.location_pin, color: AppConstants.green,),
                        labelText: 'Dirección',
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
                          return "Ingresa una dirección";
                        }else{
                          null;
                        }
                      }
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: GestureDetector(
                        onTap: pickHour1,
                        child: Container(
                            padding: const EdgeInsets.all(12),
                            height: 50,
                            width: 200,
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.3),
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text('Desde', style: TextStyle(color: Colors.white),),
                                Text(selectedTime1!.format(context), style: const TextStyle(fontSize: 18, color: Colors.grey),)
                              ],
                            )
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: GestureDetector(
                        onTap: pickHour2,
                        child: Container(
                            padding: const EdgeInsets.all(12),
                            height: 50,
                            width: 200,
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.3),
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text('Hasta', style: TextStyle(color: Colors.white),),
                                Text(selectedTime2!.format(context), style: const TextStyle(fontSize: 18, color: Colors.grey),)
                              ],
                            )
                        ),
                      ),
                    )
                  ],
                ),
                //CONTRASEÑA
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                      keyboardType: TextInputType.text,
                      controller: passwordTextController,
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
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                      keyboardType: TextInputType.text,
                      controller: confirmPasswordTextController,
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
                          icon: Icon(visible == true ? Icons.visibility:Icons.visibility_off_rounded), color: Colors.grey,),
                        labelText: 'Confirmar contraseña',
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
                //REGISTRAR
                Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: MaterialButton(
                      height: 60,
                      minWidth: 350,
                      color: AppConstants.green,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18)
                      ),
                      onPressed: () async {
                        await registroUser();
                        registroDatos();
                      },
                      child: const Text('Registrarme', style: TextStyle(color: AppConstants.darkBlue, fontSize: 20, fontWeight: FontWeight.bold),)
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Ya tengo cuenta', style: TextStyle(fontSize: 15, color: Colors.white)),
                    TextButton(onPressed: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context){
                        return Login();
                      }));
                    }, child: const Text('Iniciar sesión', style: TextStyle(fontSize: 17, color: AppConstants.green),))
                  ],
                )
              ],
            ),
          ),
        )
    );
  }

  void registroDatos() {
    FirebaseFirestore.instance.collection('users')
        .doc(emailTextController.text.trim().toLowerCase())
        .set(
        {
          'empresa': empresaTextController.text.trim(),
          'rif': rifTextController.text.trim(),
          'email': emailTextController.text.trim(),
          'phone': phoneTextController.text.trim(),
          'direccion': locationTextController.text.trim(),
          'desde': selectedTime1!.hour.toString(),
          'hasta': selectedTime2!.hour.toString(),
          'password': passwordTextController.text.trim(),
          'canchas': [],
        }).then((value) {
          Navigator.pushAndRemoveUntil(context,
              MaterialPageRoute(builder: (context) => Home()),
                  (route) => false);
          print('Usuario registrado');
    }).catchError((error){
      print('Error al cargar datos');
    });
  }

  Future<void> registroUser() async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailTextController.text.trim(),
          password: passwordTextController.text.trim(),
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }
  }
}