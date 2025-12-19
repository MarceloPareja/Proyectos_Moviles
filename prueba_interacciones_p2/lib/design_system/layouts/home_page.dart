import 'package:flutter/material.dart';
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(20),
      child: Center(
        child: Column(
          children: [
            ElevatedButton(onPressed: (){
              Navigator.pushNamed(context, "/photos");
            }, child: Text("Manejo de Imagenes")),
            ElevatedButton(onPressed: (){
              Navigator.pushNamed(context, "/sensors");
            }, child: Text("Manejo de Sensores")),
            ElevatedButton(onPressed: (){
              Navigator.pushNamed(context, "/compass");
            }, child: Text("Brujula")),
          ],
        ),
      ),
    );
  }
}
