import 'package:flutter/material.dart';
import 'package:pareja_marcelo_testp2/presentation/components/my_app_bar.dart';
import 'package:pareja_marcelo_testp2/presentation/layouts/bd_list_page.dart';
import 'package:pareja_marcelo_testp2/presentation/layouts/edit_page.dart';
import 'package:pareja_marcelo_testp2/presentation/layouts/full_list_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurpleAccent)
      ),
      routes: {
        "/Characters": (context) => FullListPage(),
        "/myCharacters": (context) => BdListPage(),
        "/edit" : (context) => EditPage()
      },
      home: FullListPage(),
    );
  }
}
