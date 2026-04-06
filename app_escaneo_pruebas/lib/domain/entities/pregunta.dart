class Pregunta {
  final String id;
  final String enunciado;
  final String optA;
  final String optB;
  String? optC;
  String? optD;
  final String res;
  final int valor;
  final int prueba_id;
  Pregunta(
      { required this.id,
        required this.enunciado,
        required this.optA,
        required this.optB,
        this.optC,
        this.optD,
        required this.res,
        required this.valor,
        required this.prueba_id});


}