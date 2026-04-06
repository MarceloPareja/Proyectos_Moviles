import 'package:flutter/material.dart';
class ListaPruebas extends StatelessWidget {
  final int curso_id;
  const ListaPruebas({super.key,
  required this.curso_id
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text("Lista de Pruebas del curso ${curso_id}")
    );
  }
}
