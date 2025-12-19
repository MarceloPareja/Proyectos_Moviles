import 'package:flutter/material.dart';
/*
Este Widget es un botón que contiene texto y un icono,
Se pueden ingresar como parámetros al texto, icono del botón,
y la acción que realizará.
*/
class ActionButton extends StatelessWidget {
  final String label;
  //final IconData icon;
  final VoidCallback action;
  final Color color;
  final IconData icon;
  const ActionButton({super.key,
    this.color=Colors.blueAccent,
    required this.label,
    required this.icon,
    required this.action,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(onPressed: action,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        spacing: 5,
        children: [
          Text(label),
          Icon(icon)
        ],
      ),
      style: ButtonStyle(
          backgroundColor: WidgetStatePropertyAll(color),
          foregroundColor: WidgetStatePropertyAll(Colors.white)
      ),
    );
  }
}
