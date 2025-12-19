import 'package:proy_examen/design_system/atoms/ActionButton.dart';
import 'package:proy_examen/design_system/atoms/NumberInput.dart';
import 'package:proy_examen/design_system/atoms/ResponseText.dart';
import 'package:proy_examen/design_system/molecules/ButtonGroup.dart';
import 'package:flutter/material.dart';
import 'dart:math';
class ScientificCalculator extends StatefulWidget {
  const ScientificCalculator({super.key});

  @override
  State<ScientificCalculator> createState() => _ScientificCalculatorState();
}

class _ScientificCalculatorState extends State<ScientificCalculator> {
  int? inputValue;
  String resultMessage="";
  void getSin(){
    double result=sin(inputValue!);
    setState(() {
      resultMessage=result.toString();
    });
  }
  void getCos(){
    double result=cos(inputValue!);
    setState(() {
      resultMessage=result.toString();
    });
  }
  void getTan(){
    double result=tan(inputValue!);
    setState(() {
      resultMessage=result.toString();
    });
  }
  void getLn(){
    double result=log(inputValue!);
    setState(() {
      resultMessage=result.toString();
    });
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 800,
      padding:EdgeInsets.all(10),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        spacing: 20,
        children: [
          NumberInput(
            inputLabel: "Ingrese el número",
            action: (value)
            {
              setState(() {
                inputValue=int.parse(value);
              });
            },
          ),
          ButtonGroup(buttons: [
            ActionButton(label: "Seno", action: getSin),
            ActionButton(label: "Coseno", action: getCos),
            ActionButton(label: "Tangente", action: getTan),
            ActionButton(label: "L.Natural", action: getLn)
          ]),
          ResponseText(text: resultMessage, color: Colors.blue[600]),
        ],
      )
    );
  }
}


