import 'package:app_escaneo_pruebas/design_system/components/tile_option.dart';
import 'package:flutter/material.dart';
import '../../domain/entities/curso.dart';
class CursoItem extends StatelessWidget {
  final Curso curso;
  final VoidCallback? action;
  final VoidCallback? action2;
  final VoidCallback? action3;
  const CursoItem({super.key, required this.curso,
    required this.action,
    required this.action2,
    required this.action3,
  });

  @override
  Widget build(BuildContext context) {
    int nrc=curso.nrc;
    String materia=curso.materia;

    return Card(
      child: ListTile(
        contentPadding: EdgeInsets.all(5),
        leading: SizedBox(
          width: 150,
          child: Text("${nrc}-${materia}",
            style: TextStyle(fontWeight: FontWeight.bold,
            fontSize: 14),),
        ),
        trailing: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          spacing: 5,
          mainAxisSize: MainAxisSize.min,
          children: [
            TileOption(icon: Icons.people_alt,
                label: "Alumnos",
                action: action!
            ),
            TileOption(icon: Icons.library_books,
                label: "Pruebas",
                action: action2!
            ),
            IconButton(onPressed: action3, icon: Icon(Icons.menu))
          ],
        ),
      ),
    );
  }
}
