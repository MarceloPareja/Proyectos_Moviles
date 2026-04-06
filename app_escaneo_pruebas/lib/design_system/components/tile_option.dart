import 'package:flutter/material.dart';
class TileOption extends StatelessWidget {
  final VoidCallback action;
  final IconData icon;
  final String label;
  const TileOption({super.key,
    required this.icon,
    required this.label,
    required this.action});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: action,
      child: Column(
        spacing: 5,
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Icon(icon),
          Text(label)
        ],
      ),
    );
  }
}
