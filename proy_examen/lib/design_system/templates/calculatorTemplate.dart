import 'package:proy_examen/design_system/atoms/NavigationButton.dart';
import 'package:proy_examen/design_system/atoms/SizeSelector.dart';
import 'package:proy_examen/design_system/organisms/DogAgeCalculator.dart';
import 'package:proy_examen/design_system/organisms/ScientificCalculator.dart';
import 'package:proy_examen/design_system/organisms/navigationBar.dart';
import 'package:proy_examen/design_system/pages/MathPage.dart';
import 'package:flutter/material.dart';

import '../pages/DogPage.dart';
class CalculatorTemplate extends StatelessWidget {
  final String title;
  final String buttonLabel;
  final VoidCallback buttonAction;
  final Widget content;
  const CalculatorTemplate({super.key, required this.title, required this.buttonLabel, required this.buttonAction, required this.content});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SwitchBar(title: title, options: [
        IconButton(onPressed: (){Navigator.push(context, MaterialPageRoute(builder: (context) => DogPage()));}, icon: Icon(Icons.pets)),
        IconButton(onPressed: (){Navigator.push(context, MaterialPageRoute(builder: (context) => MathPage()));}, icon: Icon(Icons.calculate_outlined)),
      ]),
    body: Column(
      spacing: 20,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        content,
        NavigationButton(action: buttonAction, text: buttonLabel)
      ],
    ),
    );
  }
}
