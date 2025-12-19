import 'package:app_manejo_estados_globales/design_system/atoms/passwordInput.dart';
import 'package:app_manejo_estados_globales/design_system/molecules/loginForm.dart';
import 'package:flutter/material.dart';
import 'package:app_manejo_estados_globales/design_system/atoms/textInput.dart';

//Página de inicio de sesión

class loginPage extends StatelessWidget {
  const loginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          height: 300,
          width: 300,
          child: loginForm(),
          ),
        ),
    );
  }
}
