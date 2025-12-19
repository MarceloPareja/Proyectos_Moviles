import 'desing_system/layouts/api_consumer_page.dart';
import 'desing_system/layouts/character_edit_page.dart';
import 'desing_system/layouts/bd_caracters.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        "/character_list": (context)=>ApiConsumerPage(),
        "/edit": (context)=>CharacterEditPage(),
        "/my_chars":(context)=>BdCaracters()
      },
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurpleAccent)
      ),
        debugShowCheckedModeBanner: false,
      home: ApiConsumerPage(),
    );
  }
}
