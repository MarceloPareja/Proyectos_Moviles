import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:testscanner/data/remote_repositories/pregunta_repository.dart';
import 'package:testscanner/domain/services/test_grader.dart';
import '../../data/remote_repositories/prueba_estudiante_repository.dart';
import '../../data/remote_repositories/estudiante_repository.dart';
import '../../domain/entities/estudiante.dart';
import '../../domain/entities/prueba_estudiante.dart';
import '../../domain/entities/pregunta.dart';
class GradedTestLayout extends StatefulWidget {
  final PruebaEstudiante testData;
  final int nrc;
  GradedTestLayout({super.key, required this.testData, required this.nrc});

  @override
  State<GradedTestLayout> createState() => _GradedTestLayoutState();
}

class _GradedTestLayoutState extends State<GradedTestLayout> {
  PruebaEstudianteRepository _repository = PruebaEstudianteRepository();
  PreguntaRepository _preguntaRepository = PreguntaRepository();
  EstudianteRepository _estudianteRepository = EstudianteRepository();
  TestGrader _grader = TestGrader();
  List<Pregunta>? _preguntas;
  Estudiante? _estudiante;
  

  void getData() async{
    final pregunutas = await _preguntaRepository.getList(widget.testData.prueba_id);
    final estudiante = await _estudianteRepository.getById(widget.testData.estudiante_id);
    setState(() {
      _preguntas=pregunutas;
      _estudiante=estudiante;
    });
  }
  @override
 void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }



  @override
  Widget build(BuildContext context) {
    if (_preguntas == null || _estudiante == null) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }
    return PopScope(
        onPopInvoked: (didPop) {
          if(didPop) return;
          context.go("/courses/${widget.nrc}/tests");
        },
        canPop: false,
        child: SafeArea(
          child: Scaffold(
                appBar: AppBar(
          title: Text("Resultados - ${_estudiante!.nombre}"),
          centerTitle: true,
                ),
            body: ListView.builder(
              itemCount: _preguntas!.length,
                itemBuilder: (context, index){
              return Card(
                child: Row(
                  spacing: 5,
                  mainAxisSize: MainAxisSize.min,
                  children: [SizedBox(width: 150, child: Text("${index+1}. ${_preguntas![index].enunciado}")),
                    SizedBox(width: 40, child: Text("${widget.testData.respuestas[(index).toString()]}")),
                    SizedBox(width: 40,child: Text("${_preguntas![index].res}")),
                    SizedBox(width: 40,child: Text("${_grader.gradeQuestion(_preguntas![index], widget.testData.respuestas[(index).toString()])}")),],
                )
              );
            }
          )),
        ));
  }
}

