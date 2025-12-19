import 'package:flutter/material.dart';
import 'package:prueba_interacciones_p2/design_system/components/my_app_bar.dart';
import 'package:prueba_interacciones_p2/design_system/layouts/home_page.dart';
import 'design_system/layouts/photo_usage_page.dart';
import 'design_system/layouts/sensors_page.dart';
import 'design_system/layouts/compass_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.lightGreen)
      ),
      debugShowCheckedModeBanner: false,
      routes: {
        "/photos": (context) => PhotoUsagePage(),
        "/sensors": (context) => SensorsPage(),
        "/compass": (context) => CompassPage()
      },
      home: Scaffold(
        appBar: MyAppBar(),
        body: HomePage(),
      ),
    );
  }
}
