import 'package:flutter/material.dart';

//Clase para modelar al usuario

class User {
  String name;
  String password;
  Color colorPreference;
  String userImage;
  User({
    required this.name,
    required this.password,
    required this.userImage,
    this.colorPreference = Colors.blue,
  });
  ColorScheme getUserTheme()
  {
    ColorScheme userTheme=ColorScheme.fromSeed(seedColor: colorPreference);
    return userTheme;
  }
}