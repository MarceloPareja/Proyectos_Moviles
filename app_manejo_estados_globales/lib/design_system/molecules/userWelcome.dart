import 'package:app_manejo_estados_globales/design_system/atoms/profileImage.dart';
import 'package:flutter/material.dart';

import '../atoms/userDataLabel.dart';
class userWelcome extends StatelessWidget {
  const userWelcome({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        spacing: 15,
        children: [
          Text("Bienvenido otra vez:"),
          profileImage(),
          userLabel()
        ],
      ),
    );
  }
}
