import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../components/molecules/basic_list_item.dart';
import '../../domain/services/aiken_parser.dart';
import '../../domain/entities/pregunta.dart';
import 'package:file_picker/file_picker.dart';
import '../../data/services/pregunta_services.dart';
import 'package:path/path.dart';
import 'dart:io';
class PreguntasAddLayout extends StatefulWidget {
  final String prueba_id;
  final int curso_id;
  const PreguntasAddLayout({super.key, required this.prueba_id,
    required this.curso_id});

  @override
  State<PreguntasAddLayout> createState() => _PreguntasAddLayoutState();
}

class _PreguntasAddLayoutState extends State<PreguntasAddLayout> {
  PreguntaServices _service = PreguntaServices();
  FilePickerResult? _picked_file;
  File? _questions_file;
  List<Pregunta> preguntas=[];
  AikenParser _parser = AikenParser();
  bool _loading = false;

  Future<bool> saveQuestions() async
  {
    setState(() {
      _loading = true;
    });
    bool success = await _service.bulkAddQuestions(preguntas, widget.prueba_id);
    setState(() {
      _loading = false;
    });
    return success;
  }

  void _AddQuestions(BuildContext context) async {
    if (await saveQuestions()) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              duration: Duration(seconds: 2),
              backgroundColor: Colors.green,
              content: Text('¡Preguntas agregadas exitosamente!')
          ));
      context.go("/courses/${widget.curso_id}/tests");
    }
    else
      {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              duration: Duration(seconds: 2),
              content: Text('¡Error al agregar preguntas!'),
                backgroundColor: Colors.red,
            ));
      }
  }

  void _uploadFile(BuildContext context) async{
    try{
      _picked_file = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['txt'],
      );
      if(_picked_file != null){
        setState(() {
          _questions_file = File(_picked_file!.files.single.path!);
          print(_questions_file!.path);
        });
      }
    }catch(e)
    {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            duration: Duration(seconds: 2),
            content: Text('¡Error al eliminar curso!'),
            backgroundColor: Colors.red,
          ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
        canPop: false,
        onPopInvoked: (didPop) {
          if (didPop) return;
          context.go("/courses/${widget.curso_id}/tests/${widget.prueba_id}");
        },
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          centerTitle: true,
          title: Text("Preguntas", style: TextStyle(fontSize: 20), textAlign: TextAlign.center),
        ),
        body: SafeArea(child: Center(
          child: (!preguntas.isEmpty) ?
          (Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: ListView.builder(itemBuilder: (context, index) {
                  return BasicListItem(text: "${preguntas[index].numero}. ${preguntas[index].enunciado}");
                }, itemCount: preguntas.length),
              ),
              SizedBox(
                  width: 250,
                  height: 50,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    spacing: 15,
                    children: [
                      OutlinedButton(onPressed: (){
                        //Cancela la carga de preguntas
                        context.go("/courses/${widget.curso_id}/tests");
                      }, child: Text("Cancelar")),
                      OutlinedButton(onPressed: (){
                        //Crea las preguntas en la base de datos
                        _AddQuestions(context);
                      }, child: Text("Guardar")),
                    ],
                  )
              )
            ],
          )
          ) : (_loading) ? Center(child: CircularProgressIndicator()) : (Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              spacing: 30,
              children: [
              Text((_questions_file != null) ? basename(_questions_file!.path) : "No hay archivo cargado",
            style: TextStyle(fontSize: 12,
                fontWeight: FontWeight.bold)),
          OutlinedButton(onPressed: (){
            _uploadFile(context);
          }, child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            spacing: 2,
            children: [
              Text("Cargar Archivo .txt"),
              Icon(Icons.upload_file)
            ],
          )
          ),
          OutlinedButton(onPressed: () async{
            if (_questions_file != null) {
              if(await _parser.getQuestions(_questions_file!.path))
              {
                setState(() {
                  preguntas = _parser.preguntas;
                });
                print(preguntas.toString());
              }
            }
          },
            child: Text("Leer preguntas"),
            style: ButtonStyle(
              backgroundColor: (_questions_file != null) ? MaterialStateProperty.all(Colors.blue) : MaterialStateProperty.all(Colors.grey[300]),
              foregroundColor: (_questions_file != null) ? MaterialStateProperty.all(Colors.white) : MaterialStateProperty.all(Colors.grey[700]),
            ),)
          ],
        ))
          )
        )
      ),
    );
  }
}
