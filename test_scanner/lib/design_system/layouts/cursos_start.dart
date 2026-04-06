import '../../design_system/components/curso_item.dart';
import '../../domain/entities/curso.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CursosStart extends StatelessWidget {
  const CursosStart({super.key});





  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          margin: EdgeInsets.symmetric(vertical: 5, horizontal: 2),
            child: Center(
              child: Column(
                spacing: 10,
                children: [
                  Text("Lista de Cursos"),
                  CursoItem(curso: new Curso(27846, "Aplicaciones Moviles"),
                    action: (){
                      context.push("/courses/students", extra: 28753);
                    },
                    action2: (){
                      context.push("/courses/tests", extra: 28753);
                    },action3: (){},
                  )
                ],
              )
            ),
            ),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: (){},
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [Icon(Icons.add)],
            ),
          ),
          SizedBox(width: 5,)
        ],
      ),
    );
  }
}
