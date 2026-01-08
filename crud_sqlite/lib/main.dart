import 'package:flutter/material.dart';
import 'db/database_helper.dart';

void main() {
  runApp( MainApp());
}

class MainApp extends StatelessWidget {
  MainApp({super.key});
  final db=DatabaseHelper();

  void _insertData() async{
    await db.insertData("Marcelo Pareja", "marcelo.pareja@gmail.com");
  }

  void _getData()async{
    await db.readData();
  }

  void _updateData()async{
    await db.updateData(1, "Marcelo", "marcelo@gmail.com");
  }

  void _deleteData() async{
    await db.deleteData(1);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              spacing: 20,
              children: [
                ElevatedButton(onPressed: () {
                  _insertData();
                },
                    child: Text("Insertar")),
                ElevatedButton(onPressed: () {
                  _getData();
                },
                    child: Text("Leer")),
                ElevatedButton(onPressed: () {
                  _updateData();
                },
                    child: Text("Actualizar")),
                ElevatedButton(onPressed: () {
                  _deleteData();
                },
                    child: Text("Eliminar")),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
