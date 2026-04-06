import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:testscanner/data/remote_repositories/estudiante_repository.dart';
import 'package:testscanner/design_system/components/molecules/graded_student_item.dart';
import 'package:testscanner/domain/entities/estudiante.dart';
import '../../data/remote_repositories/prueba_repository.dart';
import '../../data/remote_repositories/prueba_estudiante_repository.dart';
import '../../domain/entities/prueba.dart';
import '../../domain/entities/prueba_estudiante.dart';
class GradedStudents extends StatefulWidget {
  final String prueba_id;
  final int curso_id;
  GradedStudents({super.key,
    required this.curso_id,
    required this.prueba_id
  });

  @override
  State<GradedStudents> createState() => _GradedStudentsState();
}

class _GradedStudentsState extends State<GradedStudents> {

  void getStudent() async{
    _estudiantes = await _estudianteRepository.getList(widget.curso_id);
  }
  Estudiante matchStudentId(String id)
  {
    Estudiante estudiante= _estudiantes.where((e)=>e.id==id).single;
    return estudiante;
  }
  PruebaEstudianteRepository _repository = PruebaEstudianteRepository();
  EstudianteRepository _estudianteRepository = EstudianteRepository();
  PruebaRepository _pruebaRepository = PruebaRepository();
  late List<PruebaEstudiante> _gradedTests;
  late List<Estudiante> _estudiantes;

  @override
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getStudent();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(onPopInvoked: (didPop) {
      if(didPop) return;

      context.go("/courses/${widget.curso_id}/tests");
    },
        child: SafeArea(child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: Text("Resultados de la prueba", style: TextStyle(fontSize: 20), textAlign: TextAlign.center),
          ),
          body: FutureBuilder(future: _repository.getList(widget.prueba_id),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  }
                  if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return Center(child: Text('Aún no hay estudiantes en este curso'));
                  }
                  if (snapshot.hasData) {
                    return ListView.builder(itemCount: snapshot.data?.length,
                      itemBuilder: (context, index) {
                        return GradedStudentItem(estudiante: matchStudentId(snapshot.data![index].estudiante_id).nombre,
                            grade: snapshot.data![index].calificacion,
                            check: () {
                              context.go("/courses/${widget.curso_id}/tests/${widget.prueba_id}/graded/check",
                                  extra: snapshot.data![index]);
                            }
                        );
                      },
                    );
                  }
                  else {
                    return CircularProgressIndicator();
                  }
                })
          ),
        ));
  }
}
