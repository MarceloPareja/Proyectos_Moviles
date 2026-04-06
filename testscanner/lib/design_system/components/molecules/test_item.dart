import '../atoms/tile_option.dart';
import 'package:flutter/material.dart';
import '../../../domain/entities/prueba.dart';
class TestItem extends StatelessWidget {
  final Prueba prueba;
  final VoidCallback? report_action;
  final VoidCallback? action2;
  final VoidCallback? question_action;
  final VoidCallback edit_action;
  final VoidCallback delete_action;
  final VoidCallback grade_action;
  const TestItem({super.key, required this.prueba,
     required this.grade_action,
     this.report_action,
     this.action2,
     this.question_action,
    required this.edit_action,
    required this.delete_action
  });

  @override
  Widget build(BuildContext context) {
    int nrc=prueba.curso_id;
    String titulo=prueba.titulo;

    return Card(
      child: ListTile(
        contentPadding: EdgeInsets.all(5),
        leading: SizedBox(
          width: 150,
          child: Text("${nrc}-${titulo}",
            style: TextStyle(fontWeight: FontWeight.bold,
                fontSize: 14),),
        ),
        trailing: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          spacing: 5,
          mainAxisSize: MainAxisSize.min,
          children: [
            TileOption(icon: Icons.quiz_outlined,
                label: "preguntas",
                action: question_action!
            ),
            TileOption(icon: Icons.picture_as_pdf,
                label: "Imprimir",
                action: action2!
            ),
            PopupMenuButton(itemBuilder: (context)=>[
              PopupMenuItem(child: Text("Reporte"),
                onTap: grade_action,),
              PopupMenuItem(child: Text("Editar"),
                onTap: edit_action,),
              PopupMenuItem(child: Text("Eliminar"),
                onTap: delete_action,),
            ])
          ],
        ),
      ),
    );
  }
}
