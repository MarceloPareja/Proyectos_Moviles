import 'package:flutter/material.dart';
import 'package:interacciones_dispositivo/layouts/compass_page.dart';
import 'package:interacciones_dispositivo/layouts/home_page.dart';
import 'package:interacciones_dispositivo/layouts/pick_image_page.dart';
import 'package:interacciones_dispositivo/layouts/sensor_screen.dart';

void main() {
  runApp( MaterialApp(
    routes: {
      "/fotos": (context) => PickImagePage(),
      "/sensor": (context) => SensorScreen(),
      "/compass": (context)=> CompassPage()
    },
    theme: ThemeData(
      colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueAccent)
    ),
    debugShowCheckedModeBanner: false,
    home: HomePage()
  ));
}

