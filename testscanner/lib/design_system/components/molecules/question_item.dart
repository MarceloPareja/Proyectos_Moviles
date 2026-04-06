import 'package:flutter/material.dart';
import '../atoms/tile_option.dart';
class QuestionItem extends StatelessWidget {
  final String pregunta;
  final int numero;
  final VoidCallback? edit_action;
  final VoidCallback? delete_action;
  QuestionItem({super.key, required this.pregunta,
    required this.numero,
    required this.edit_action,
    required this.delete_action,
  });
  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        contentPadding: EdgeInsets.all(5),
        leading: SizedBox(
            width: 200,
            child: Text("${numero + 1}. $pregunta",
              style: TextStyle(fontWeight: FontWeight.bold,
                  fontSize: 14),)
        ),
        trailing: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          spacing: 5,
          mainAxisSize: MainAxisSize.min,
          children: [
            TileOption(icon: Icons.edit,
                label: "Editar",
                action: edit_action!
            ),
            TileOption(icon: Icons.delete,
                label: "Eliminar",
                action: delete_action!
            )
          ],
        ),
      ),
    );
  }
}