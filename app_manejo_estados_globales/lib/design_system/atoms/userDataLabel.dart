import 'package:app_manejo_estados_globales/global_state/loginData.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

/*Este widget muestra el nombre del usuario en pantalla*/

class userLabel extends StatelessWidget {
  const userLabel({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<loginData>(
        builder: (context, loginData, child){
          return Text(
            loginData.usuario.name,
            style: TextStyle(
              fontSize: 30,
              letterSpacing: 2.0,
              fontWeight: FontWeight.bold
            ),
          );
        });
  }
}
