import '../db/database_helper.dart';
import 'package:sqflite/sqflite.dart';
import '../../domain/entities/profesor.dart';
/*
class ProfesorRepository {
  final DatabaseHelper _dbHelper = DatabaseHelper();
  static const table = "profesor";
  Future<bool> create(Map<String, dynamic> data) async{
    try{
      final db = await _dbHelper.dbConnect();
      await db.insert(
          table,
          data,
          //Evita conflictos de IDs reemplazando los valores
          conflictAlgorithm: ConflictAlgorithm.replace
      );
      print("Insercion exitosa");
      await db.close();
      return true;
    }
    catch(err)
    {
      return false;
    }
  }

  Future<List<Profesor>> getList() async{
    final db = await _dbHelper.dbConnect();
    final data = await db.query(table);
    await  db.close();
    List<Profesor> list = [];
    for(var item in data){
      Profesor profesor = Profesor(item["id"] as int, item["usuario"] as String, item["nombre"] as String);
      list.add(profesor);
    }
    return list;
  }

  Future<List<Map<String, dynamic>>> readData() async{
    final db = await _dbHelper.dbConnect();
    final data = await db.query(table);
    await  db.close();
    return data;
  }

  Future<Profesor> getById(int id) async{
    final db = await _dbHelper.dbConnect();
    final data = await db.query(table, where: "id=?", whereArgs: [id]);
    await  db.close();
    final profesor_info = data[0];
    Profesor profesor = Profesor(profesor_info["id"] as int,
        profesor_info["usuario"] as String,
        profesor_info["nombre"] as String);
    return profesor;
  }

  Future<void> update(int id, Map<String, dynamic> data) async{
    final db = await _dbHelper.dbConnect();
    int id = 1;
    //Actualiza los datos
    await db.update(
        table,
        data,
        where: "id=?",
        whereArgs: [id]
    );
    await db.close();
  }

  Future<void> delete(int id)async{
    final db = await _dbHelper.dbConnect();
    await db.delete(table,
        where: "id = ?",
        whereArgs: [id]);
    await db.close();
  }
}*/