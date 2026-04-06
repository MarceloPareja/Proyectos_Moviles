import '../db/database_helper.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sql.dart';
import 'package:path/path.dart';
class PruebaRepository {
  final DatabaseHelper _dbHelper = DatabaseHelper();
  static const table = "prueba";
  Future<void> crearPrueba(String fecha, int nrc, String introduccion ) async{
    final db = await _dbHelper.dbConnect();
    await db.insert(
        table,
        {
          "fecha":fecha,
          "introduccion":introduccion,
          "curso_id":nrc
        },
        //Evita conflictos de IDs reemplazando los valores
        conflictAlgorithm: ConflictAlgorithm.replace
    );
    print("Insercion exitosa");
    await db.close();
    return null;
  }

  Future<List<Map<String, dynamic>>> obtenerListaPruebas() async{
    final db = await _dbHelper.dbConnect();
    final data = await db.query(table);
    print(data);
    await  db.close();
    return data;
  }

  Future<List<Map<String, dynamic>>> obtenerPruebasCurso(int nrc) async{
    final db = await _dbHelper.dbConnect();
    final data = await db.query(table,
        where: "curso_id=",
        whereArgs: [nrc]);
    print(data);
    await  db.close();
    return data;
  }

  Future<Map<String, dynamic>> obtenerPrueba(int id) async{
    final db = await _dbHelper.dbConnect();
    final data = await db.query(table,
        where: "id=",
        whereArgs: [id]);
    print(data);
    await  db.close();
    return data[0];
  }

  Future<void> actualizarPrueba(int id, Map<String, dynamic> data) async{
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