import 'dart:io';

class PruebaEstudiante {
  final String id;
  final String estudiante_id;
  final String prueba_id;
  final File imagen;
  final double calificacion;
  final Map<String, dynamic> respuestas;

  PruebaEstudiante({
    required this.id,
    required this.estudiante_id,
    required this.prueba_id,
    required this.imagen,
    required this.calificacion,
    required this.respuestas
});
}