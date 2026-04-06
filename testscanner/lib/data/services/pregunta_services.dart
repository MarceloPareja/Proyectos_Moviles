import '../remote_repositories/pregunta_repository.dart';
import '../remote_repositories/prueba_repository.dart';
import '../../domain/entities/pregunta.dart';
import '../../domain/entities/prueba.dart';
class PreguntaServices {
  PreguntaRepository _repository = PreguntaRepository();
  PruebaRepository _pruebaRepository = PruebaRepository();

  //Ajusta los numeros de pregunta después de eliminar una
  Future<void> _updatePlaces(String prueba_id)async{
    List<Pregunta> preguntas = await _repository.getList(prueba_id);
    for(int i=0; i<preguntas.length; i++)
      {
        if(preguntas[i].numero!=(i+1))
          {
            preguntas[i].numero=i+1;
            await _repository.update(preguntas[i]);
          }
      }
  }

  Future<bool> bulkAddQuestions(List<Pregunta> preguntas, String prueba_id) async{
    int counter = 1;
    for(Pregunta pregunta in preguntas)
      {
        pregunta.numero = counter;
        counter++;
        if(!await addQuestion(pregunta, prueba_id))
          {
            return false;
          }
      }
    return true;
  }

  Future<bool> addQuestion(Pregunta pregunta, String prueba_id) async{
    //Crea la pregunta
    bool success = await _repository.crearPregunta(
        pregunta.enunciado,
        pregunta.opciones,
        pregunta.res,
        pregunta.valor,
        prueba_id);

    if(!success)
      {
        return false;
      }
    //Actualiza la nota maxima de la prueba
    Prueba datos = await _pruebaRepository.getById(prueba_id);
    datos.nota_max += pregunta.valor;
    bool updated = await _pruebaRepository.update(datos);
    if(!updated)
      {
        return false;
      }
    return true;
  }




  Future<bool> deleteQuestion(String id, String prueba_id) async{
    bool resultado = await _repository.deleteData(id, prueba_id);
    if(resultado)
      {
        _updatePlaces(prueba_id);
        return true;
      }
    else
      {
        return false;
      }
  }
}