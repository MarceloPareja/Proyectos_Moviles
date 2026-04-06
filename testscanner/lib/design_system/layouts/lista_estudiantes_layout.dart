import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:testscanner/design_system/components/molecules/student_item.dart';
import '../../data/remote_repositories/estudiante_repository.dart';
class ListaEstudiantesLayout extends StatefulWidget {
  final int curso_id;
  const ListaEstudiantesLayout({super.key, required this.curso_id});
  @override
  State<ListaEstudiantesLayout> createState() => _ListaEstudiantesLayoutState();
}

class _ListaEstudiantesLayoutState extends State<ListaEstudiantesLayout> {
  final _repository = EstudianteRepository();
  TextEditingController _studentController = TextEditingController();


  Future<void> agregarEstudiante() async
  {
    String nombreEstudiante = _studentController.text;
    bool success = await _repository.create(nombreEstudiante, widget.curso_id);
    if(success)
    {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          duration: Duration(seconds: 2),
          content: Text('Estudiante agregado'),
          backgroundColor: Colors.green,
        ),
      );
      _studentController.clear();
      setState(() {

      });
    }
    else
    {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            duration: Duration(seconds: 2),
            content: Text('Error al agregar estudiante'),
            backgroundColor: Colors.red,
          ));
      _studentController.clear();
    }
  }

  Future<void> openDialog(BuildContext context) async {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return AlertDialog(
            title: Text("Agregar estudiante al curso"),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  width: 250,
                  height: 75,
                  child: TextField(
                    maxLines: null,
                    expands: true,
                    textAlignVertical: TextAlignVertical.top,
                    controller: _studentController,
                    decoration: InputDecoration(labelText: "Nombre del estudiante",
                    hintText: "Nombre Completo",
                    border: OutlineInputBorder()),
                  ),
                )
              ],
            ),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text("Cancelar")),
              TextButton(
                  onPressed: () {
                    agregarEstudiante();
                    Navigator.of(context).pop();
                  },
                  child: Text("Agregar"))
            ],
          );
        }
    );
  }

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
          title: Text("Estudiantes - NRC ${widget.curso_id}", style: TextStyle(fontSize: 20), textAlign: TextAlign.center),
        ),
        body: SafeArea(child: Center(
            child:
            FutureBuilder(future: _repository.getList(widget.curso_id),
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
                        return StudentItem(estudiante: snapshot.data![index].nombre,
                            action2: () {}, action3: () {});
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
            openDialog(context);
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
