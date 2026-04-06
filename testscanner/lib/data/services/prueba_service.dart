import '../remote_repositories/prueba_repository.dart';
import '../remote_repositories/pregunta_repository.dart';
class PruebaService {
  final PruebaRepository _repository = PruebaRepository();
  final PreguntaRepository _preguntaRepository = PreguntaRepository();
  Future<String> getLastId(int curso_id) async
  {
    List<Map<String, dynamic>> lista = await _repository.getOrderedIds(curso_id);
    lista.sort(
        (a, b) => a["timestamp"].compareTo(b["timestamp"])
    );
    return lista.last["id"];
  }

  Future<bool> hasQuestions(String prueba_id) async{
    List lista = await _preguntaRepository.getList(prueba_id);
    if(lista.isEmpty)
      {
        return false;
      }
    else
      {
        return true;
      }
  }

}
