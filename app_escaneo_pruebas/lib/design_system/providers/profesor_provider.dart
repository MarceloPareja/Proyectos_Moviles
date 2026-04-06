import 'package:flutter/material.dart';
import '../../domain/entities/profesor.dart';

class ProfesorProvider extends ChangeNotifier {
  Profesor? user;

 Profesor? get userData => user;
 bool get isLogged => user != null;

 void setUser(Profesor user) {
    this.user=user;
    notifyListeners();
  }

  void logout() {
    user = null;
    notifyListeners();
  }
}
