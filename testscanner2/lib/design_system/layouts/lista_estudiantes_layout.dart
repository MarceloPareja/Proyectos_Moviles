import 'package:flutter/material.dart';
class ListaEstudiantesLayout extends StatelessWidget {
  final int cursoId;
  const ListaEstudiantesLayout({super.key, required this.cursoId});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text("Lista de Estudiantes del curso ${cursoId}")
    );
  }
}
