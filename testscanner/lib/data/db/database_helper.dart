import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
class DatabaseHelper {
  late var path;
  Future<Database> dbConnect() async{
    //Obtiene la direccion de la BD
    final databasePath = await getDatabasesPath();
    //Establece una direccion para guardar la BD
    path = join(databasePath,"gradesDb");
    return openDatabase(
      path,
      onCreate: (db,version) async{
        //Crear tablas
        //Tabla profesor
        await db.execute("CREATE TABLE profesor(id INTEGER PRIMARY KEY, nombre TEXT NOT NULL, usuario TEXT NOT NULL, clave TEXT NOT NULL, logged INTEGER DEFAULT 0) ");
        //Tabla curso
        await db.execute("CREATE TABLE curso(nrc INTEGER PRIMARY KEY, materia TEXT NOT NULL)");
        //Tabla estudiante
        await db.execute("CREATE TABLE estudiante(id INTEGER PRIMARY KEY, nombre TEXT NOT NULL, curso_id INTEGER NOT NULL) ");
        //Tabla prueba
        await db.execute("CREATE TABLE prueba(id INTEGER PRIMARY KEY, fecha TEXT NOT NULL, introduccion TEXT, nota_max INTEGER DEFAULT 0, curso_id INTEGER NOT NULL )");
        //Tabla pregunta
        await db.execute("CREATE TABLE pregunta(id INTEGER PRIMARY KEY, enunciado TEXT NOT NULL, preguntas TEXT NOT NULL, res TEXT NOT NULL, valor INTEGER DEFAULT 1, prueba_id INTEGER NOT NULL ) ");
        //Tabla pruebaEstudiante
        await db.execute("CREATE TABLE prueba_estudiante(id INTEGER PRIMARY KEY, imagen BLOB NOT NULL, calificacion REAL NOT NULL, respuestas TEXT NOT NULL, prueba_id INTEGER NOT NULL, estudiante_id INTEGER NOT NULL) ");
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


}