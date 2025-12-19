import 'package:flutter/material.dart';

import '../../../datos/repository_impl.dart';
import '../components/my_app_bar.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController usernameControl=TextEditingController();
  TextEditingController passwordControl=TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: MyAppBar(),
        body: Container(
          child: Column(
            children: [
              Text("Iniciar Sesiòn",
                style: TextStyle(fontWeight: FontWeight.bold),),
              SizedBox(height: 20),
              SizedBox(width: 170,
                child: TextField(
                  controller: usernameControl,
                  decoration: InputDecoration(
                      labelText: "Usuario"
                  ),
                ),),
              SizedBox(height: 20),
              SizedBox(width: 170,
                child: TextField(
                  controller: passwordControl,
                  decoration: InputDecoration(
                      labelText: "Contraseña"
                  ),
                ),),
              SizedBox(height: 10,),
              ElevatedButton(onPressed: () async {
                bool validated = await RepositoryImpl().
                loginUser(usernameControl.text, passwordControl.text);
                if (validated) {
                  Navigator.pushNamed(context, "/users");
                }
                else {
                  print("No se ha ingresado");
                }
              }, child: Text("Ingresar"))
            ],
          ),
        )
    );
  }
}
