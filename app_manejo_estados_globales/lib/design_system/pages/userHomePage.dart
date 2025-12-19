import 'dart:math';

import 'package:app_manejo_estados_globales/design_system/atoms/AppTitle.dart';
import 'package:app_manejo_estados_globales/design_system/atoms/passwordInput.dart';
import 'package:app_manejo_estados_globales/design_system/atoms/userDataLabel.dart';
import 'package:app_manejo_estados_globales/design_system/molecules/loginForm.dart';
import 'package:app_manejo_estados_globales/design_system/molecules/userWelcome.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../global_state/loginData.dart';

//Página de Inicio de usuario

class userHomePage extends StatelessWidget {
  const userHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    /* TODO: Envolver el Scaffold con consumer para recibir el color
    */
    return Consumer<loginData>(builder: (context, loginData, child){
      return Scaffold(
        backgroundColor: loginData.usuario.getUserTheme().primaryContainer,
        appBar: AppBar(
          title: appTitle(),
          foregroundColor: loginData.usuario.getUserTheme().onPrimary,
          backgroundColor: loginData.usuario.getUserTheme().primary,
          actions: [
            IconButton(icon: Icon(Icons.logout_outlined), onPressed: (){
              loginData.clearUser();
              Navigator.pop(context);
            })
          ],
        ),
        body: Center(
          child: Container(
            width: 300,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              spacing: 15,
              children: [
                userWelcome()
              ],
            ),
          ),
        ),
      );
    },);
  }
}
