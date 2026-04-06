import 'package:flutter/material.dart';
import '../atoms/tile_option.dart';
class GradedStudentItem extends StatelessWidget {
  final String estudiante;
  final VoidCallback check;
  final double grade;
  GradedStudentItem({super.key, required this.estudiante, required this.grade,
    required this.check
  });
  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        contentPadding: EdgeInsets.all(5),
        leading: Icon(Icons.person),
        title: Text(estudiante,
        style: TextStyle(fontWeight: FontWeight.bold,
            fontSize: 14),
        ),
        subtitle: Text("Nota: $grade",
          style: TextStyle(fontSize: 12),
        ),
        trailing: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          spacing: 5,
          mainAxisSize: MainAxisSize.min,
          children: [
            TileOption(icon: Icons.remove_red_eye,
                label: "Revisar",
                action: check
            )
          ],
        ),
      ),
    );
  }
}
