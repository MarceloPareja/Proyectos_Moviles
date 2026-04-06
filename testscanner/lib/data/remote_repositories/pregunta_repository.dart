import 'package:cloud_firestore/cloud_firestore.dart';
import '../../domain/entities/pregunta.dart';

FirebaseFirestore fireDB = FirebaseFirestore.instance;
class PreguntaRepository {

  Future<bool> crearPregunta(String enunciado, Map<String, dynamic> opciones, String res, int valor, String prueba_id) async{
    CollectionReference preguntas = fireDB.collection("pruebas").doc(prueba_id).collection("preguntas");
    QuerySnapshot query = await preguntas.get();
    int nextPlace = query.docs.length;
    try{
      await preguntas.add({
        "enunciado":enunciado,
        "numero":nextPlace,
        "opciones":opciones,
        "respuesta":res,
        "valor":valor
      }
      );
      print("Insercion exitosa");
      return true;
    }
    catch(e){
      return false;
    }
  }

  Future<List<Pregunta>> getList(String id_prueba) async {
    CollectionReference preguntas = fireDB.collection("pruebas").doc(id_prueba).collection("preguntas");
    List<Pregunta> lista_preguntas = [];
    QuerySnapshot query = await preguntas.orderBy("numero", descending: false).get();
    for (var pregunta in query.docs) {
      lista_preguntas.add(
          Pregunta(
              id: pregunta.id,
              numero: pregunta["numero"],
              enunciado: pregunta["enunciado"],
              opciones: pregunta["opciones"],
              res: pregunta["respuesta"],
              valor: pregunta["valor"],
              prueba_id: id_prueba
          )
          );
    }
    return lista_preguntas;
  }
  Future<Pregunta> getById(String id, String prueba_id) async {
    CollectionReference preguntas = fireDB.collection("pruebas").doc(prueba_id).collection("preguntas");
    Pregunta pregunta;
    DocumentSnapshot data = await preguntas.doc(id).get();
    pregunta = new Pregunta(
        id: data.id,
        numero: data["numero"],
        enunciado: data["enunciado"],
        opciones: data["opciones"],
        res: data["respuesta"],
        valor: data["valor"],
        prueba_id: prueba_id
    );
    return pregunta;
  }

  Future<bool> update(Pregunta datos) async{
    CollectionReference preguntas = fireDB.collection("pruebas").doc(datos.prueba_id).collection("preguntas");
    //Actualiza los datos
    Map<String, dynamic> data = {
      "numero":datos.numero,
      "enunciado":datos.enunciado,
      "opciones":datos.opciones,
      "respuesta":datos.res,
      "valor":datos.valor
    };
    try{
      await preguntas.doc(datos.id).update(data);
      return true;
    }
    catch(e)
    {
      return false;
    }
  }

  Future<bool> deleteData(String id, String prueba_id)async{
    CollectionReference preguntas = fireDB.collection("pruebas").doc(prueba_id).collection("preguntas");
    try{
      await preguntas.doc(id).delete();
      return true;
    }
    catch(e)
    {
      return false;
    }
  }
}