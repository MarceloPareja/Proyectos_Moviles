import 'package:flutter/material.dart';
import 'menu_label.dart';

class MenuItem extends StatelessWidget{
  final String label;
  bool? selected=false;
  MenuItem({super.key,
    required this.label,
    this.selected
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      color: selected! ? ColorScheme.of(context).surface : ColorScheme.of(context).surfaceDim,
      padding: const EdgeInsetsGeometry.symmetric(
          vertical: 8.0,
          horizontal: 5.0
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        spacing: 10.0,
        children: [
          MenuLabel(labelText: label),
        ],
      ),
    );
  }
}