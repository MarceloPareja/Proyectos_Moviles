import 'dart:io';

class PruebaEstudiante {
   String id;
   String estudiante_id;
   String prueba_id;
   double calificacion;
   Map<String, dynamic> respuestas;

  PruebaEstudiante({
    required this.id,
    required this.estudiante_id,
    required this.prueba_id,
    required this.calificacion,
    required this.respuestas
});
}