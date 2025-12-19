import 'package:flutter/material.dart';
class SizeSelector extends StatefulWidget {
  final Function(int) newAction;
  SizeSelector({super.key, required this.newAction});
  @override
  State<SizeSelector> createState() => _SizeSelectorState();
}

class _SizeSelectorState extends State<SizeSelector> {
  int value=0;
  @override
  Widget build(BuildContext context) {
    return DropdownButton<int>(
      value: value,
      onChanged:(int? newVal){
        setState(() {
          value=newVal!;
        });
        widget.newAction(value);
      },
      items: const [
        DropdownMenuItem(
          value: 0,
          child: Text("Pequeña"),
        ),
        DropdownMenuItem(
          value: 1,
          child: Text("Mediana"),
        ),
        DropdownMenuItem(
          value: 2,
          child: Text("Grande"),
        )
      ]
    )
;
  }
}
