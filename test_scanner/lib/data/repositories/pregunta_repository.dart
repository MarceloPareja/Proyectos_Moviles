import '../db/database_helper.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sql.dart';
import 'package:path/path.dart';
class PruebaRepository {
  final DatabaseHelper _dbHelper = DatabaseHelper();
  static const table = "pregunta";
  Future<void> crearPrueba(Map<String, dynamic> data, int prueba_id) async{
    final db = await _dbHelper.dbConnect();
    await db.insert(
        table,
        {
          "enunciado":data["enunciado"],
          "optA":data["A"],
          "optB":data["B"],
          "optC":data["C"],
          "optD":data["D"] ,
          "res":data["res"],
          "valor":data["valor"],
          "prueba_id":prueba_id
        },
        //Evita conflictos de IDs reemplazando los valores
        conflictAlgorithm: ConflictAlgorithm.replace
    );
    print("Insercion exitosa");
    await db.close();
    return null;
  }

  Future<List<Map<String, dynamic>>> obtenerListaPreguntas() async{
    final db = await _dbHelper.dbConnect();
    final data = await db.query(table);
    print(data);
    await  db.close();
    return data;
  }

  Future<List<Map<String, dynamic>>> obtenerPreguntasPrueba(int prueba_id) async{
    final db = await _dbHelper.dbConnect();
    final data = await db.query(table,
        where: "prueba_id=",
        whereArgs: [prueba_id]);
    print(data);
    await  db.close();
    return data;
  }

  Future<Map<String, dynamic>> obtenerPregunta(int id) async{
    final db = await _dbHelper.dbConnect();
    final data = await db.query(table,
        where: "id=",
        whereArgs: [id]);
    print(data);
    await  db.close();
    return data[0];
  }

  Future<void> actualizarPregunta(int id, Map<String, dynamic> data) async{
    final db = await _dbHelper.dbConnect();
    //Actualiza los datos
    await db.update(
        table,
        data,
        where: "id=?",
        whereArgs: [id],
        conflictAlgorithm: ConflictAlgorithm.replace
    );
    await db.close();
  }

  Future<void> deleteData(int id)async{
    final db = await _dbHelper.dbConnect();
    await db.delete(table,
        where: "id = ?",
        whereArgs: [id]);
    await db.close();
  }
}