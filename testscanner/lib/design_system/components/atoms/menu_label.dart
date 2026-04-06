import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
class MenuLabel extends StatelessWidget{
  final String labelText;
  const MenuLabel(
      {super.key,
        required this.labelText,
      });

  Widget build(BuildContext context) {
    return Text(labelText,
        style: TextStyle(
            fontSize: 18,
            color: ColorScheme.of(context).primary,
        ));
  }
}