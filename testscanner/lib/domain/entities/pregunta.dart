class Pregunta {
   String id;
   int numero;
   String enunciado;
   Map<String, dynamic> opciones;
   String res;
   int valor;
   String prueba_id;
  Pregunta(
      { required this.id,
        required this.numero,
        required this.enunciado,
        required this.opciones,
        required this.res,
        required this.valor,
        required this.prueba_id
      }
      );
}