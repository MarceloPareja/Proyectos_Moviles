import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/user.dart';

/*Estado global para el manejo de datos del usuario*/


class loginData extends ChangeNotifier{
  User usuario=User(name: "", password: "", userImage: "");

  //Lista de usuarios registrados
  List<User> users=[
    User(name: "mpareja", password: "Mpareja.1203", colorPreference: Colors.red,
    userImage: 'images/fotoPerfil_marcelo.png'),
    User(name: "simonB97", password: "libertadores97", colorPreference: Colors.yellow,
    userImage: 'images/fotoPerfil_simon.jpg'),
    User(name: "manuelita", password: "manuela123",
        userImage: 'images/fotoPerfil_manuela.jpg'),
  ];

//Esta función acepta credenciales y selecciona al usuario
  void acceptData(String new_username, String new_password)
  {
    for(User user in users){
      if(user.name==new_username && user.password==new_password)
      {
        usuario=user;
      }
    }
    notifyListeners();
  }

  void clearUser()
  {
    usuario=User(name: "", password: "", userImage: "");
    notifyListeners();
  }
  /*Esta función verifica que un usuario y contraseña
  pertenezcan a un usuario registrado
   */
  bool validateUser(String username, String password)
  {
      bool result=false;
      if(users.length!=0)
      {
        for(User user in users){
          if(user.name==username && user.password==password)
          {
          return true;
          }
        }
      }
      return result;
  }

}