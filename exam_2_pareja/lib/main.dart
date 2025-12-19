import 'package:exam_2_pareja/presentacion/design_system/layouts/add_page.dart';
import 'package:exam_2_pareja/presentacion/design_system/layouts/login_page.dart';
import 'package:exam_2_pareja/presentacion/design_system/layouts/user_list_page.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        "/add" : (context)=>AddPage(),
        "/users":(context)=>UserListPage(),
      },
      home: LoginPage()
    );
  }
}
