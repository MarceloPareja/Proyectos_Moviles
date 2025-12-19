import 'package:app_manejo_estados_globales/design_system/pages/loginPage.dart';
import 'package:app_manejo_estados_globales/global_state/loginData.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(create:
    (context)=> loginData(),
    child: MaterialApp(
      debugShowCheckedModeBanner: false,
      home: loginPage(),
    ))
  );
}