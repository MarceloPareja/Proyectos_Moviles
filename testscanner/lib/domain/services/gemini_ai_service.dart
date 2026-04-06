import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_ai/firebase_ai.dart';
import 'package:testscanner/domain/entities/estudiante.dart';
import 'dart:io';
import 'dart:convert';
import '../../firebase_options.dart';

class GeminiAiService {
  final model = FirebaseAI.googleAI().generativeModel(model: 'gemini-3-flash-preview');

  Future<Map<String, dynamic>> getTestResults (File image) async{
    final action = """
    Podrías escanear esta imagen, y devolver como resultado un JSON de una sola línea con los siguientes datos:
    {
    title: El titulo de la prueba
    name: El nombre del alumno,
    nrc: El NRC del curso como numero,
    date: La fecha de la prueba como String en formato ISO8601,
    0: La respuesta a la pregunta 1(Solo la letra o letras encerradas),
    ... y así para las demás preguntas,
    1: Si la pregunta está sin contestar entonces retorna un string vacío
    2: A,B,C si se han encerrado varias opciones de la respuesta
    }
    """;
    final prompt=TextPart(action);
    final considerations = """
    """;
    final imageReceiver = await image.readAsBytes();
    final preparedImage = InlineDataPart("image/jpeg", imageReceiver);
    final response = await model.generateContent(
      [Content.multi([prompt, preparedImage])]
    );
    print(response.text);
    Map<String, dynamic> responseMap = json.decode(response.text!);
    return responseMap;
  }

  Future<String?>  getClosestStudent(String name, List<Estudiante> students) async{
    String studentlist="[";
    for(Estudiante student in students) {
      studentlist += "${student.id} - ${student.nombre}, ";
    }
    studentlist+="]";
    print(studentlist);
    String closest="";
    final action = """
    Podrías escanear esta lista ${studentlist}, y devolver como resultado el nombre del alumno más cercano al nombre $name
    Solo dame el id del estudiante en la lista y si no lo encuentras, regresa un string vacío. 
    """;
    final prompt=[Content.text(action)];
    final considerations = """
    """;
    final response = await model.generateContent(
        prompt
    );
    print(response.text);
    return response.text;
  }
}