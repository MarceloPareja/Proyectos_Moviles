import 'package:cloud_firestore/cloud_firestore.dart';
import '../../domain/entities/prueba.dart';

FirebaseFirestore fireDB = FirebaseFirestore.instance;
class PruebaRepository {
  CollectionReference pruebas = fireDB.collection("pruebas");
  Future<bool> crearPrueba(String titulo, DateTime fecha, int nrc, String introduccion ) async{
    try{
      await pruebas.add({
        "titulo":titulo,
        "fecha": fecha.toIso8601String(),
        "introduccion": introduccion,
        "curso_id": nrc,
        "nota_max": 0,
        "timestamp": DateTime.now()
      }
      );
      print("Insercion exitosa");
      return true;
    }
    catch(e){
        return false;
    }
  }

  DateTime _parseStringDate(String date){
    int year=int.parse(date.substring(0,4));
    int month=int.parse(date.substring(5,7));
    int day=int.parse(date.substring(8,10 ));
    return DateTime(year, month, day);
  }

  Future<List<Prueba>> getList(int id_curso) async {
    List<Prueba> lista_pruebas = [];
    QuerySnapshot query = await pruebas.where("curso_id", isEqualTo: id_curso).get();
    for (var prueba in query.docs) {
      lista_pruebas.add(
          Prueba(
              prueba.id,
              prueba["curso_id"] as int,
              prueba["titulo"],
              _parseStringDate(prueba["fecha"]),
              prueba["introduccion"],
              prueba["nota_max"]
          )
      );
    }
    print(lista_pruebas);
    return lista_pruebas;
  }

  Future<List<Map<String, dynamic>>> getRawList(int id_curso) async{
    List<Map<String, dynamic>> lista_pruebas = [];
    QuerySnapshot query = await pruebas.where("curso_id", isEqualTo: id_curso).get();
    for (var prueba in query.docs) {
      lista_pruebas.add(prueba.data() as Map<String, dynamic>);
    }
    return lista_pruebas;
  }

  Future<List<Map<String, dynamic>>> getOrderedIds(int id_curso) async{
    List<Map<String, dynamic>> lista_pruebas = [];
    QuerySnapshot query = await pruebas.where("curso_id", isEqualTo: id_curso).get();
    for (var prueba in query.docs) {
      lista_pruebas.add({
        "id": prueba.id,
        "timestamp": prueba["timestamp"]
      });
    }
    return lista_pruebas;
  }



  Future<Prueba> getById(String id) async {
    Prueba prueba;
    DocumentSnapshot data = await pruebas.doc(id).get();
    prueba = new Prueba(
        data.id,
        data["curso_id"] as int,
        data["titulo"],
        _parseStringDate(data["fecha"]),
        data["introduccion"],
        data["nota_max"]
    );
    return prueba;
  }

  Future<String> getIdByDataCombination(String titulo, String fecha, int nrc)async
  {
    List<Prueba> data = await getList(nrc);
    for(var prueba in data)
    {
      if(prueba.titulo==titulo && prueba.fecha==_parseStringDate(fecha))
      {
        return prueba.id;
      }
    }
    return "";
  }

  Future<bool> update(Prueba datos) async{
    //Actualiza los datos
    Map<String, dynamic> data = {
      "titulo":datos.titulo,
      "curso_id":datos.curso_id,
      "fecha":datos.fecha.toIso8601String(),
      "introduccion":datos.introduccion,
      "nota_max":datos.nota_max
    };
    try{
      await pruebas.doc(datos.id).update(data);
      return true;
    }
    catch(e)
    {
      return false;
    }
  }

  Future<bool> deleteData(String id)async{
    try{
      await pruebas.doc(id).delete();
      return true;
    }
    catch(e)
    {
      return false;
    }
  }
}