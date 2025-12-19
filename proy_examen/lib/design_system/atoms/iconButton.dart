import 'package:flutter/material.dart';
class IconButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback action;
  const IconButton({super.key, required this.icon, required this.action});

  @override
  Widget build(BuildContext context) {
    return IconButton(icon: icon, action: action);
  }
}
