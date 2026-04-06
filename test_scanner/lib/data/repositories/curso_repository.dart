import '../db/database_helper.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sql.dart';
class CursoRepository {
  final DatabaseHelper _dbHelper = DatabaseHelper();
  static const table = "curso";
  Future<void> crearCurso(int nrc, String materia) async{
    final db = await _dbHelper.dbConnect();
    await db.insert(
        table,
        {
          "nrc":nrc,
          "materia":materia
        },
        //Evita conflictos de IDs reemplazando los valores
        conflictAlgorithm: ConflictAlgorithm.replace
    );
    print("Insercion exitosa");
    await db.close();
    return null;
  }

  Future<List<Map<String, dynamic>>> obtenerCursos() async{
    final db = await _dbHelper.dbConnect();
    final data = await db.query(table);
    await  db.close();
    return data;
  }

  Future<Map<String, dynamic>> obtenerInfoCurso(int nrc)async{
    final db = await _dbHelper.dbConnect();
    final data = await db.query(table,
    where: "nrc=",
    whereArgs: [nrc]);
    await  db.close();
    return data[0];
  }

  Future<void> actualizarCurso(int nrc, Map<String, dynamic> data) async{
    final db = await _dbHelper.dbConnect();
    int id = 1;
    //Actualiza los datos
    await db.update(
        table,
        {
          "nrc":data["nombre"],
          "materia":data["materia"]
        },
        where: "id=?",
        whereArgs: [id]
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