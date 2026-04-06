import '../../data/remote_repositories/estudiante_repository.dart';
import '../../domain/entities/estudiante.dart';

import '../../data/remote_repositories/pregunta_repository.dart';
import '../../data/remote_repositories/prueba_estudiante_repository.dart';
import '../../data/remote_repositories/prueba_repository.dart';
import '../entities/pregunta.dart';
import '../entities/prueba.dart';
class TestGrader {
  final _repository = PruebaEstudianteRepository();
  final _pruebaRepository = PruebaRepository();
  final _preguntaRepository = PreguntaRepository();
  final _estudianteRepository = EstudianteRepository();



  double gradeQuestion(Pregunta pregunta, String respuesta)
  {
    //Selección Múltiple
    double student_score=0.0;
    double max_score=pregunta.valor.toDouble();
    if(pregunta.res.length>1) {
      double answer_portion=max_score/pregunta.res.length;

      //Quita las comas de la respuesta
      List<String> correct_answer = pregunta.res.split(",");
      //Quita las comas de la respuesta
      List<String> user_answer = respuesta.split(",");
      for (String choice in user_answer) {
        if(correct_answer.contains(choice))
        {
          student_score+=answer_portion;
        }
      }
      }
    //Selección Simple, verdadero o falso, o llenar
    else{
      if(pregunta.res==respuesta)
        {
          student_score=max_score;
        }
    }
    return student_score;
  }

  Future<void> gradeTest(String prueba_id,
      Map <String, dynamic> results,
      String estudiante_id) async{
      Prueba datosPrueba = await _pruebaRepository.getById(prueba_id);
      List<Pregunta> preguntas = await _preguntaRepository.getList(prueba_id);
      Estudiante estudiante = await _estudianteRepository.getById(estudiante_id);
      double score = 0.0;
      for (Pregunta pregunta in preguntas) {
        final key = pregunta.numero.toString();

        if (results.containsKey(key)) {
          score += gradeQuestion(pregunta, results[key]);
        }
      }
      //Guarda los resultados
      await _repository.create(estudiante_id, results, score, prueba_id);
      print("Prueba: ${datosPrueba.titulo}, Estudiante: ${estudiante.nombre}");
      print("Nota: $score");
  }

  }
