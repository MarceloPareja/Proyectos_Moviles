import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_ai/firebase_ai.dart';
import 'dart:io';
import 'dart:convert';
import '../../firebase_options.dart';

class GeminiAiService {
  final model = FirebaseAI.googleAI().generativeModel(model: 'gemini-3-flash-preview');

  Future<Map<String, dynamic>> getTestResults (File image) async{
    final action = """
    Podrías escanear esta imagen, y devolver como resultado un JSON de una sola línea con los siguientes datos:
    {name: El nombre del alumno,
    Q1: La respuesta a la pregunta 1(Solo la letra),
    ... y así para las demás preguntas
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
}