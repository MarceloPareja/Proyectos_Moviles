import 'dart:io';
import 'package:path/path.dart';
import '../../domain/entities/pregunta.dart';
class AikenParser {
  File? textfile;
  RegExp answerPrefix = RegExp(r'^ANSWER:\s*[A-Z,]+');
  RegExp numerationPrefixes = RegExp(r'^\d+[.)]\s');
  RegExp questionPrefix = RegExp(r'^(?=([A-Z][.)]\s)).+');
  List<Pregunta> preguntas = [];


  void _getFile(String filename)
  {
    //Obtiene el archivo en base al nombre
    var filePath = join(Directory.current.path, filename);
    textfile = File(filePath);
  }

  Future<bool> getQuestions(String filename) async{
    try{
      preguntas.clear();
      //Obtiene el archivo
      _getFile(filename);
      //Lee el archivo y guarda las líneas
      List<String> lines= await textfile!.readAsLines();
      int counter=1;//Cuenta la posición de la pregunta
      List<String> question=[];//Guarda las líneas de una pregunta
      for(String line in lines)
      {
        //Si encuentra ANSWER, signfifica que ya se ha leído una pregunta
        if(line.contains("ANSWER"))
        {
          question.add(line);
          //Envía la pregunta a procesar
          if(!processQuestion(question, counter))
          {
            return false;
          }
          //Limpia el arreglo de preguntas
          //Coloca el número de la siguiente pregunta
          counter++;
          //Limipia el contenedor de pregunta
          question.clear();
          continue;
        }
        if(line=="")//Ignora líneas vacías
            {
          continue;
        }
        question.add(line);//Si no es linea vacía o answer, agrega la línea a la pregunta
      }
      return true;
    }
    catch(e)
    {
      return false;
    }
  }

  //Valida que el enunciado no tenga enumeración
  bool _validateQuestion(String enunciado)
  {
    if(!numerationPrefixes.hasMatch(enunciado))
      {
        return true;
      }
    print("Error en formato de enunciado");
    return false;
  }
  //Valida que la opción tenga letra
  bool _validateOption(String option)
  {
    if(questionPrefix.hasMatch(option))
      {
        return true;
      }
    print("Error en formato de opción");
    return false;

  }

  //Valida que la opción sea una letra
  bool _validateAnswer(String answer)
  {
    final clean = answer
        .replaceAll('\uFEFF', '')
        .trim();
    return answerPrefix.hasMatch(clean);
  }

  bool processQuestion(List<String> question, int number)
  {
    try{
      print("Pregunta $number");
      //Extrae enunciado y respuesta
      String enunciado = question.first;
      String respuesta = question.last;
      print(enunciado);
      print(respuesta);
      //Valida enunciado
      if(!_validateQuestion(enunciado))
      {
        return false;
      }
      //Valida respuesta
      if(!_validateAnswer(respuesta))
      {
        print("Error en formato de respuesta");
        return false;
      }
      //Deja solo el valor de la respuesta
      respuesta = respuesta
          .replaceAll('\uFEFF', '')
          .trim()
          .substring(7)
          .trim();
      //Deja solo un arreglo de opciones
      question.removeAt(0);
      question.removeAt(question.length-1);
      List<String> options = question;
      //Valida cada respuesta
      for(String option in options) {
        if (!_validateOption(option)) {
          return false;
        }
      }
      //Crea la pregunta
      Pregunta pregunta = _craftQuestion(enunciado, respuesta, options, number);
      //Agrega a la lista final
      preguntas.add(pregunta);
      print(pregunta);
      return true;
    }catch(e)
    {
      print(e);
      return false;
    }
  }

  Pregunta _craftQuestion(String enunciado, String respuesta, List<String> opciones, int numero) {
    Map<String, dynamic> options = Map.fromIterable(opciones,
        key: (e) => e[0],
        value: (e) => e.substring(3)
    );
    print(options);
    return Pregunta(
        id: "",
        numero: numero,
        enunciado: enunciado,
        opciones: options,
        res: respuesta,
        valor: 1,
        prueba_id: ""
    );
  }
      
      

  }