import 'package:basedatos_firebase_moviles/layouts/addPage.dart';
import 'package:basedatos_firebase_moviles/layouts/HomePage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'firebase_options.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MaterialApp(
    routes: {
  // When navigating to the "/" route, build the FirstScreen widget.
  '/home': (context) => const HomePage(),
  // When navigating to the "/second" route, build the SecondScreen widget.
  '/add': (context) => const Addpage(),
  },
    home: HomePage(),
  ));
}
