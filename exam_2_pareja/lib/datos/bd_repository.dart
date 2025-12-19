import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../dominio/models/user.dart';
FirebaseFirestore fireDB=FirebaseFirestore.instance;
class BdRepository {
  Future<List> getUsers() async{
    List<User> userlist=[];
    CollectionReference userCollection=fireDB.collection("users");
    QuerySnapshot queryData=await userCollection.get();
    for(var user in queryData.docs)
    {
      userlist.add(User(user.id,user["username"],user["password"]));
    }
    await Future.delayed(Duration(seconds: 2));
    return userlist;
  }
  Future<bool> addUser(String username, String password) async{
    CollectionReference userCollection=fireDB.collection("users");
    Map<String, dynamic> userData={
      "username":username,
      "password":password
    };
    try{
      await userCollection.add(userData);
      return true;
    }
    catch(e){
      return false;
    }
  }
  Future<bool> updateUser(User updatedUser) async{
    CollectionReference userCollection=fireDB.collection("users");
    Map<String, dynamic> userData={
      "username":updatedUser.username,
      "password":updatedUser.password
    };
    try{
      await userCollection.doc(updatedUser.id).update(userData);
      return true;
    }
    catch(e){
      return false;
    }
  }
  Future<bool> deleteUser(String id) async{
    CollectionReference userCollection=fireDB.collection("users");
    try{
      await userCollection.doc(id).delete();
      return true;
    }
    catch(e){
      return false;
    }
  }
  Future<bool> login(String username, String password) async{
    bool validated=false;
    CollectionReference userCollection=fireDB.collection("users");
    QuerySnapshot query=await userCollection.get();
    for(var user in query.docs)
      {
        if(user["username"]==username && user["password"]==password)
          {
            validated=true;
          }
      }
    return validated;
  }
}
