import 'package:flutter/material.dart';
import '../atoms/tile_option.dart';
class StudentItem extends StatelessWidget {
  final String estudiante;
  final VoidCallback? action2;
  final VoidCallback? action3;
  StudentItem({super.key, required this.estudiante,
    required this.action2,
    required this.action3,
  });
  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        contentPadding: EdgeInsets.all(5),
        leading: SizedBox(
          width: 200,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            spacing: 5,
            children: [
              Icon(Icons.person),
              SizedBox(
                width: 150,
                  child: Text(estudiante,
                    style: TextStyle(fontWeight: FontWeight.bold,
                        fontSize: 14),)
              )
            ],
          ),
        ),
        trailing: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          spacing: 5,
          mainAxisSize: MainAxisSize.min,
          children: [
            TileOption(icon: Icons.edit,
                label: "Editar",
                action: action2!
            ),
            TileOption(icon: Icons.delete,
                label: "Eliminar",
                action: action3!
            )
          ],
        ),
      ),
    );
  }
}
