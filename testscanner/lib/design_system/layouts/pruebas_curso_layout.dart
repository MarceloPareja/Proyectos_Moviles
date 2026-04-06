import 'dart:io';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:testscanner/data/remote_repositories/pregunta_repository.dart';
import 'package:testscanner/design_system/providers/profesor_provider.dart';
import '../../data/services/prueba_service.dart';
import '../../domain/entities/pregunta.dart';
import '../../domain/services/pdf_generator.dart';
import '../components/molecules/test_item.dart';
import '../../data/remote_repositories/prueba_repository.dart';
class PruebasCursoLayout extends StatefulWidget {
  final int curso_id;
  const PruebasCursoLayout({super.key, required this.curso_id});

  @override
  State<PruebasCursoLayout> createState() => _PruebasCursoLayoutState();
}

class _PruebasCursoLayoutState extends State<PruebasCursoLayout> {
  final PruebaRepository _repository = PruebaRepository();
  final PruebaService _service = PruebaService();
  final PreguntaRepository _preguntaRepository = PreguntaRepository();
  final PdfGenerator _pdfGenerator = PdfGenerator();


  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) {
        if(didPop) return;
        context.go("/courses");
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text("Pruebas - NRC ${widget.curso_id}", style: TextStyle(fontSize: 20), textAlign: TextAlign.center),
        ),
        body: SafeArea(child: Center(
            child:
            FutureBuilder(future: _repository.getList(widget.curso_id),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  }
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  }
                  if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return Center(child: Text('Aún no hay pruebas en este curso'));
                  }
                  if (snapshot.hasData) {
                    print(snapshot.data);
                    return ListView.builder(itemCount: snapshot.data?.length,
                      itemBuilder: (context, index) {
                        return TestItem(prueba: snapshot.data![index],
                          report_action: (){

                          },
                            grade_action: (){
                              context.go("/courses/${widget.curso_id}/tests/${snapshot.data![index].id}/graded");
                            },
                          action2: () async {
                          List<Pregunta> preguntas = await _preguntaRepository.getList(snapshot.data![index].id);
                            File pdf = await _pdfGenerator.generatePdf(snapshot.data![index],
                                Provider.of<ProfesorProvider>(context, listen: false).user!.nombre,
                                widget.curso_id, preguntas);
                            await _pdfGenerator.openPdf(pdf);
                          },
                          question_action: ()async {
                          //Preguntas
                            if(await _service.hasQuestions(snapshot.data![index].id)){
                              context.go("/courses/${widget.curso_id}/tests/${snapshot.data![index].id}/questions");
                            }
                            else{
                            context.go("/courses/${widget.curso_id}/tests/${snapshot.data![index].id}/questions/add");
                            }
                          },
                          edit_action: () {},
                          delete_action: () {}
                          );
                      },
                    );
                  }
                  else {
                    return CircularProgressIndicator();
                  }
                })
        )
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            context.go("/courses/${widget.curso_id}/tests/create");
          },
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [Icon(Icons.add)],
          ),
        ),
      ),
    );
  }
}
