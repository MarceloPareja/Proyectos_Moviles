import 'package:flutter/material.dart';

/*Un texto modificado para que actúe como título*/

class appTitle extends StatelessWidget {
  const appTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      "Login App",
      style: TextStyle(
        fontSize: 23,
      ),
    );
  }
}
