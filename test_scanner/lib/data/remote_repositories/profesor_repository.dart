import 'package:cloud_firestore/cloud_firestore.dart';
import '../../domain/entities/profesor.dart';
FirebaseFirestore fireDB = FirebaseFirestore.instance;
class ProfesorRepository {
  CollectionReference profesorCollection = fireDB.collection("profesor");
  Future<bool> create(String email, String nombre, String clave) async{
    try{
      await profesorCollection.add({
        "emaul":email,
        "name":nombre,
        "password":clave,
      });
      print("Insercion exitosa");
      return true;
    }
    catch(err)
    {
      return false;
    }
  }

  Future<List<Profesor>> getList() async {
    List<Profesor> profesores = [];
    QuerySnapshot query = await profesorCollection.get();
    for (var profesor in query.docs) {
      profesores.add(Profesor(profesor["id"] as String,
          profesor["email"] as String,
          profesor["name"] as String));
    }
    return profesores;
  }

  Future<List<Map<String, dynamic>>> getRawList() async{
    QuerySnapshot query = await profesorCollection.get();
    return query.docs as List<Map<String, dynamic>>;
  }

  Future<Profesor> getById(String id) async{
    Profesor profesor;
    DocumentSnapshot queryData = await profesorCollection.doc(id).get();
    profesor = new Profesor(queryData["id"] as String,
        queryData["email"] as String,
        queryData["name"] as String);
    return profesor;
  }

  Future<bool> update(String id, Profesor profesor) async{
    //Actualiza los datos
    Map<String, dynamic> data = {
      "email":profesor.email,
      "name":profesor.nombre
    };
    try{
      await profesorCollection.doc(id).update(data);
      return true;
    }
    catch(e)
    {
      return false;
    }
  }

  Future<bool> delete(String id)async{
    try{
      await profesorCollection.doc(id).delete();
      return true;
    }
    catch(e){
      return false;
    }
  }

}