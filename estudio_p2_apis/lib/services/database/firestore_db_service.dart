import 'package:cloud_firestore/cloud_firestore.dart';

FirebaseFirestore firebaseDB = FirebaseFirestore.instance;
Future<List> getAllCharacters()async{
  List characters=[];
  CollectionReference charactersCollection=firebaseDB.collection("characters");//Obtender la coleccion
  //Hacer la consulta para obtener los documentos
  QuerySnapshot querySnapshot=await charactersCollection.get();
  for(var character in querySnapshot.docs){
    characters.add(character.data());
  }
  await Future.delayed(Duration(seconds: 2));//Espera 2 segundos al agregar
  return characters;
  }

  Future<bool> addCharacter(
      String name, String species, String planet, String image
      )async{
      Map<String, dynamic> newCharacter={
        "name":name,
        "species":species,
        "planet":planet,
        "Image":image
      };
      try{
        await firebaseDB.collection("characters").add(newCharacter);
        return true;
      }catch(e){
        return false;
      }
}



