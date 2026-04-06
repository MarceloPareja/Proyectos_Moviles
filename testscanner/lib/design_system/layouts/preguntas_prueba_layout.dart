import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:testscanner/design_system/components/molecules/question_item.dart';
import '../../data/remote_repositories/pregunta_repository.dart';
import '../../data/services/pregunta_services.dart';
import '../../domain/entities/pregunta.dart';
class PreguntasPruebaLayout extends StatefulWidget {
  String prueba_id;
  int curso_id;
  PreguntasPruebaLayout({super.key,
    required this.prueba_id,
    required this.curso_id
  });

  @override
  State<PreguntasPruebaLayout> createState() => _PreguntasPruebaLayoutState();
}

class _PreguntasPruebaLayoutState extends State<PreguntasPruebaLayout> {
  PreguntaRepository _repository = PreguntaRepository();

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) {
        if(didPop) return;

        context.go("/courses/${widget.curso_id}/tests");
      },
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text("Preguntas"),
        ),
        body: SafeArea(child: Center(
            child: FutureBuilder(future: _repository.getList(widget.prueba_id),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  }
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  }
                  if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return Center(
                        child: Text('Aún no hay preguntas en esta prueba'));
                  }
                  if (snapshot.hasData) {
                    print(snapshot.data);
                    return ListView.builder(
                        itemCount: snapshot.data?.length,
                        itemBuilder: (context, index) {
                      return QuestionItem(pregunta: snapshot.data![index].enunciado,
                          numero: snapshot.data![index].numero,
                          edit_action: () {
                            context.go("/courses/${widget.curso_id}/tests/${widget.prueba_id}/questions/edit/${snapshot.data![index].id}",
                            extra: snapshot.data![index]);
                          },
                          delete_action: () {});
                    });
                        }
                  else {
                    return CircularProgressIndicator();
                  }
                }
                )
        )
        )
      ),
    );
  }
}
