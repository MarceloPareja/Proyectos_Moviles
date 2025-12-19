import 'package:proy_examen/design_system/organisms/DogAgeCalculator.dart';
import 'package:proy_examen/design_system/templates/calculatorTemplate.dart';
import 'package:flutter/material.dart';
class DogPage extends StatelessWidget {
  const DogPage({super.key});

  @override
  Widget build(BuildContext context) {
    return CalculatorTemplate(title: "Calculadora de Edad Perros", buttonLabel: "Regresar",
        buttonAction: (){Navigator.pop(context);}, content: DogAgeCalculator());
  }
}
