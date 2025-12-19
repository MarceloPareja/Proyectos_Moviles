import 'package:proy_examen/design_system/organisms/ScientificCalculator.dart';
import 'package:proy_examen/design_system/templates/calculatorTemplate.dart';
import 'package:flutter/material.dart';

import 'DogPage.dart';
class MathPage extends StatelessWidget {
  const MathPage({super.key});

  @override
  Widget build(BuildContext context) {
    return CalculatorTemplate(
      title: "Calculadora cientifica",
      content: ScientificCalculator(),
      buttonAction: (){
        Navigator.push(context, MaterialPageRoute(builder: (context) =>  DogPage()));
      },
      buttonLabel: "Ir a calculadora perruna",
    );
  }
}
