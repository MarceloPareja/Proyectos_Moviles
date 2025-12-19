import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

FirebaseFirestore fireDB=FirebaseFirestore.instance;
Future<List> getAllUsers() async{
  List users=[];
  CollectionReference usuarios = fireDB.collection('users');
  QuerySnapshot querySnapshot = await usuarios.get();//Es un context de la consulta
  for(var user in querySnapshot.docs)
  {
    users.add(user.data());
    print(user.data());//Agregamos el usuario de la consulta a la lista local
  }
  await Future.delayed(const Duration(seconds: 5));
  return users;
}

Future<bool> putUser(String name, String email)async{
  Map<String, dynamic> user = {
    'name': name,
    'email': email,
  };
  try{
    await fireDB.collection('users').add(user);
    return true;
  }catch(e){
    return false;
  }

}