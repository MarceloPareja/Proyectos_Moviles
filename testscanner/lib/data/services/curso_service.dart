import '../remote_repositories/curso_repository.dart';
import '../remote_repositories/estudiante_repository.dart';
import '../remote_repositories/prueba_repository.dart';
import '../../domain/entities/estudiante.dart';
import '../../domain/entities/prueba.dart';
import '../../domain/entities/curso.dart';

class CursoService {
  EstudianteRepository _estudianteRepository = EstudianteRepository();
  PruebaRepository _pruebaRepository = PruebaRepository();
  CursoRepository _repository = CursoRepository();

  Future<bool> eliminarCurso(int nrc, String profesor_id) async{
    //Elimina los estudiantes del curso
    List<Estudiante> estudiantes = await _estudianteRepository.getList(nrc);
    for(var estudiante in estudiantes)
      {
        await _estudianteRepository.delete(estudiante.id);
      }

    //Elimina las pruebas del curso
    List<Prueba> pruebas = await _pruebaRepository.getList(nrc);
    for(var prueba in pruebas)
      {
        await _pruebaRepository.deleteData(prueba.id);
      }

    //Elimina el curso

    return await _repository.delete(nrc,profesor_id);
  }
}