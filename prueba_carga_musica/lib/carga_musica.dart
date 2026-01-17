import 'package:flutter/material.dart';
class CargaMusica extends StatefulWidget {
  const CargaMusica({super.key});

  @override
  State<CargaMusica> createState() => _CargaMusicaState();
}

class _CargaMusicaState extends State<CargaMusica> {
  void subirMusica(){

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(onPressed: subirMusica, child: Text("Subir musica")),
      ),
    );
  }
}
