import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sql.dart';
import 'package:path/path.dart';
class DatabaseHelper {
  late var path;
  Future<Database> _openDatabase() async{
    //Obtiene la direccion de la BD
    final databasePath = await getDatabasesPath();
    //Establece una direccion para guardar la BD
    path = join(databasePath,"firstdb");
    return openDatabase(
      path,
      onCreate: (db,version) async{
        await db.execute("CREATE TABLE users(id INTEGER PRIMARY KEY, name TEXT, email TEXT) ");
      },
      version: 1
    );
}
  /*Future<Database> _openDatabase2() async{
    //Obtiene la direccion de la BD
    final databasePath = await getDatabasesPath();
    //Establece una direccion para guardar la BD
    path = join(databasePath,"firstdb");
    return openDatabase(
        path,
        onCreate: (db,version) async{
          await db.execute("CREATE TABLE users(id INTEGER PRIMARY KEY, name TEXT, email TEXT) ");
        },
        version: 1
    );
  }*/

  Future<void> insertData(String name, String email) async{
    final db = await _openDatabase();
    await db.insert(
        "users",
      {
        "name":name,
        "email":email
      },
        //Evita conflictos de IDs reemplazando los valores
      conflictAlgorithm: ConflictAlgorithm.replace
    );
    print("Insercion exitosa");
    await db.close();
    return null;
  }

  Future<void> readData() async{
    final db = await _openDatabase();
    final data = await db.query("users");
    print(data);
    await  db.close();
  }

  Future<void> updateData(int id, String name, String email) async{
    final db = await _openDatabase();
    int id = 1;
    //Actualiza los datos
    await db.update(
        "users",
        {
          "name":name,
          "email":email
        },
        where: "id=?",
        whereArgs: [id]
    );
    await db.close();
  }

  Future<void> deleteData(int id)async{
    final db = await _openDatabase();
    await db.delete("users",
    where: "id = ?",
    whereArgs: [id]);
    await db.close();
  }
}