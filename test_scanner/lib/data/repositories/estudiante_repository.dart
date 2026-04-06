import '../db/database_helper.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sql.dart';

class EstudianteRepository {
  final DatabaseHelper _dbHelper = DatabaseHelper();
  static const table = "estudiante";
  Future<void> crearEstudiante(int nrc, String nombre ) async{
    final db = await _dbHelper.dbConnect();
    await db.insert(
        table,
        {
          "nombre":nombre,
          "curso_id":nrc
        },
        //Evita conflictos de IDs reemplazando los valores
        conflictAlgorithm: ConflictAlgorithm.replace
    );
    print("Insercion exitosa");
    await db.close();
    return null;
  }

  Future<List<Map<String, dynamic>>> obtenerListaEstudiantes() async{
    final db = await _dbHelper.dbConnect();
    final data = await db.query(table);
    print(data);
    await  db.close();
    return data;
  }

  Future<List<Map<String, dynamic>>> obtenerEstudiantesCurso(int nrc) async{
    final db = await _dbHelper.dbConnect();
    final data = await db.query(table,
    where: "curso_id=",
    whereArgs: [nrc]);
    print(data);
    await  db.close();
    return data;
  }

  Future<Map<String, dynamic>> obtenerEstudiante(int id) async{
    final db = await _dbHelper.dbConnect();
    final data = await db.query(table,
        where: "id=",
        whereArgs: [id]);
    print(data);
    await  db.close();
    return data[0];
  }

  Future<void> actualizarEstudiante(int id, String nombre) async{
    final db = await _dbHelper.dbConnect();
    //Actualiza los datos
    await db.update(
        table,
        {
          "nombre":nombre,
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