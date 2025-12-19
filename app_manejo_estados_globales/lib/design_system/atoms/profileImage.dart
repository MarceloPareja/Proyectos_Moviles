import 'dart:math';

import 'package:app_manejo_estados_globales/global_state/loginData.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class profileImage extends StatelessWidget{
  const profileImage({super.key});
  Widget build(BuildContext context) {
    return Container(
        width: 50,
        height: 50,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(25),
        child: Consumer<loginData>(builder: (context, user, child){
          return Image(image: AssetImage(user.usuario.userImage));
        },
      ),
      )
    );
  }
}