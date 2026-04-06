import 'package:cloud_firestore/cloud_firestore.dart';
import '../../domain/entities/curso.dart';
FirebaseFirestore fireDB = FirebaseFirestore.instance;
class CursoRepository {
  CollectionReference cursos = fireDB.collection("cursos");
  Future<bool> create(int nrc, String materia, String id_profesor) async{
    try{
      await cursos.add({
        "nrc":nrc,
        "materia":materia,
        "profesor_id":id_profesor
      });
      print("Insercion exitosa");
      return true;
    } 
    catch(err)
    {
      return false;
    }
  }

  Future<List<Curso>> getList(String id_profesor) async {
    List<Curso> lista_cursos = [];
    QuerySnapshot query = await cursos.where("profesor_id", isEqualTo: id_profesor).get();
    for (var curso in query.docs) {
      lista_cursos.add(
          Curso(
              curso["nrc"] as int,
              curso["materia"] as String,
              curso["profesor_id"] as String
          )
      );
    }
    return lista_cursos;
  }

  Future<Curso> getById(int nrc, String id_profesor) async{
    Curso curso;
    QuerySnapshot queryData = await cursos.where("nrc", isEqualTo: nrc).where("profesor_id", isEqualTo: id_profesor).get();
    curso = new Curso(
        queryData.docs[0]["nrc"] as int,
        queryData.docs[0]["materia"] as String,
        queryData.docs[0]["profesor_id"] as String
    );
    return curso;
  }

  Future<String> _getIdByNrc(int nrc, String id_profesor) async{
    QuerySnapshot queryData = await cursos.where("nrc", isEqualTo: nrc).where("profesor_id", isEqualTo: id_profesor).get();
    return queryData.docs[0].id;
  }

  Future<bool> update(String nrc, String id_profesor, Curso curso) async{
    //Actualiza los datos
    Map<String, dynamic> data = {
      "nrc":curso.nrc,
      "materia":curso.materia
    };
    String id=await _getIdByNrc(curso.nrc, id_profesor);
    try{
      await cursos.doc(id).update(data);
      return true;
    }
    catch(e)
    {
      return false;
    }
  }

  Future<bool> delete(int nrc, String id_profesor)async{
    String id = await _getIdByNrc(nrc, id_profesor);
    try{
      await cursos.doc(id).delete();
      return true;
    }
    catch(e){
      return false;
    }
  }

}