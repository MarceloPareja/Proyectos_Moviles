import 'package:cloud_firestore/cloud_firestore.dart';
import '../../domain/entities/estudiante.dart';
FirebaseFirestore fireDB = FirebaseFirestore.instance;
class EstudianteRepository {
  CollectionReference estudiantes = fireDB.collection("estudiantes");
  Future<bool> create(String nombre, int curso) async{
    try{
      await estudiantes.add({
        "nombre":nombre,
        "curso_id":curso
      });
      print("Insercion exitosa");
      return true;
    }
    catch(err)
    {
      return false;
    }
  }

  Future<List<Estudiante>> getList(int id_curso) async {
    List<Estudiante> lista_estudiantes = [];
    QuerySnapshot query = await estudiantes.where("curso_id", isEqualTo: id_curso).get();
    for (var alumno in query.docs) {
      lista_estudiantes.add(
          Estudiante(
              alumno.id,
              alumno["nombre"] as String,
              alumno["curso_id"] as int
          )
      );
    }
    return lista_estudiantes;
  }

  Future<Estudiante> getById(String id) async{
    Estudiante curso;
    DocumentSnapshot data = await estudiantes.doc(id).get();
    curso = new Estudiante(
        data.id,
        data["nombre"] as String,
        data["curso_id"] as int
    );
    return curso;
  }

  Future<bool> update(Estudiante datos) async{
    //Actualiza los datos
    Map<String, dynamic> data = {
      "nombre":datos.nombre,
      "curso_id":datos.curso_id
    };
    try{
      await estudiantes.doc(datos.id).update(data);
      return true;
    }
    catch(e)
    {
      return false;
    }
  }

  Future<bool> delete(String id)async{
    try{
      await estudiantes.doc(id).delete();
      return true;
    }
    catch(e){
      return false;
    }
  }
  
}