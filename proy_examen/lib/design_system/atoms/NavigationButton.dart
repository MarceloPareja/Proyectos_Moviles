import 'package:flutter/material.dart';
class NavigationButton extends StatelessWidget {
  final VoidCallback action;
  final String text;

  const NavigationButton({super.key,
    required this.action,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(onPressed: action, child: Text(text, style: TextStyle(fontSize: 20),));
  }
}
