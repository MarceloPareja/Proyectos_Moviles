import 'package:cloud_firestore/cloud_firestore.dart';
import '../../domain/entities/prueba_estudiante.dart';

FirebaseFirestore fireDB = FirebaseFirestore.instance;
class PruebaEstudianteRepository {

  Future<bool> create(String estudiante_id, Map<String, dynamic> respuestas, double calificacion, String prueba_id) async{
    CollectionReference pruebasCalificadas = fireDB.collection("pruebas").doc(prueba_id).collection("calificadas");
    QuerySnapshot query = await pruebasCalificadas.get();
    int nextPlace = query.docs.length;
    try{
      await pruebasCalificadas.add({
        "estudiante_id":estudiante_id,
        "calificacion":calificacion,
        "respuestas":respuestas
      }
      );
      print("Insercion exitosa");
      return true;
    }
    catch(e){
      return false;
    }
  }

  Future<List<PruebaEstudiante>> getList(String id_prueba) async {
    CollectionReference pruebasCalificadas = fireDB.collection("pruebas").doc(id_prueba).collection("calificadas");
    List<PruebaEstudiante> lista_pruebas = [];
    QuerySnapshot query = await pruebasCalificadas.get();
    for (var calificacion in query.docs) {
      lista_pruebas.add(
          PruebaEstudiante(
              id: calificacion.id,
              estudiante_id: calificacion["estudiante_id"],
              calificacion: calificacion["calificacion"],
              respuestas: calificacion["respuestas"],
              prueba_id: id_prueba
          )
      );
    }
    return lista_pruebas;
  }
  Future<PruebaEstudiante> getById(String id, String prueba_id) async {
    CollectionReference pruebasCalificadas = fireDB.collection("pruebas").doc(prueba_id).collection("calificadas");
    PruebaEstudiante pruebaEstudiante;
    DocumentSnapshot data = await  pruebasCalificadas.doc(id).get();
    pruebaEstudiante = new PruebaEstudiante(
        id: data.id,
        estudiante_id: data["estudiante_id"],
        calificacion: data["calificacion"],
        respuestas: data["respuestas"],
        prueba_id: prueba_id
    );
    return pruebaEstudiante;
  }

  Future<bool> update(PruebaEstudiante datos) async{
    CollectionReference pruebasCalificadas = fireDB.collection("pruebas").doc(datos.prueba_id).collection("calificadas");
    //Actualiza los datos
    Map<String, dynamic> data = {
      "estudiante_id":datos.estudiante_id,
      "calificacion":datos.calificacion,
      "respuestas":datos.respuestas
    };
    try{
      await pruebasCalificadas.doc(datos.id).update(data);
      return true;
    }
    catch(e)
    {
      return false;
    }
  }

  Future<bool> deleteData(String id, String prueba_id)async{
    CollectionReference pruebasCalificadas = fireDB.collection("pruebas").doc(prueba_id).collection("calificadas");
    try{
      await pruebasCalificadas.doc(id).delete();
      return true;
    }
    catch(e)
    {
      return false;
    }
  }
}