import 'package:proy_examen/design_system/atoms/ActionButton.dart';
import 'package:proy_examen/design_system/atoms/NumberInput.dart';
import 'package:proy_examen/design_system/atoms/ResponseText.dart';
import 'package:proy_examen/design_system/atoms/SizeSelector.dart';
import 'package:proy_examen/design_system/molecules/ButtonGroup.dart';
import 'package:flutter/material.dart';
import 'dart:math';
class DogAgeCalculator extends StatefulWidget {
  const DogAgeCalculator({super.key});

  @override
  State<DogAgeCalculator> createState() => _DogAgeCalculatorState();
}

class _DogAgeCalculatorState extends State<DogAgeCalculator> {
  int? inputValue;
  int? dogBreed;
  String resultMessage="";
  void getAge()
  {
    int result=0;
    switch(dogBreed){
      case 0:
        result=inputValue!*8;
        break;
      case 1:
        result=inputValue!*7;
        break;
      case 2:
        result=inputValue!*6;
        break;
    }
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
            inputLabel: "Edad del Perro",
            action: (value)
            {
              setState(() {
                inputValue=int.parse(value);
              });
            },
          ),
          SizeSelector(
            newAction: (value)
            {
              setState(() {
                dogBreed=value;
              });
            },
          ),
          ActionButton(label: "Calcular", action: getAge),
          ResponseText(text: resultMessage, color: Colors.teal[100]),
        ],
      )
    );
  }
}


