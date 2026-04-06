import 'package:provider/provider.dart';
import '../../data/services/curso_service.dart';

import '../../data/remote_repositories/curso_repository.dart';
import '../components/molecules/curso_item.dart';
import '../../domain/entities/curso.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../domain/entities/profesor.dart';
import '../providers/profesor_provider.dart';


class CursosStart extends StatefulWidget {
  const CursosStart({super.key});

  @override
  State<CursosStart> createState() => _CursosStartState();
}

class _CursosStartState extends State<CursosStart> {
  TextEditingController _nrcController = TextEditingController();
  TextEditingController _materiaController = TextEditingController();
  final CursoRepository _repository = CursoRepository();
  final CursoService _service = CursoService();



  Future<void> agregarCurso() async
  {
    int nrc=int.parse(_nrcController.text);
    String materia=_materiaController.text;
    String profesor_id = Provider
        .of<ProfesorProvider>(context, listen: false)
        .user!
        .id;
    bool success = await _repository.create(nrc, materia, profesor_id);
    if(success)
      {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            duration: Duration(seconds: 2),
            content: Text('¡Curso agregado exitosamente!'),
            backgroundColor: Colors.green,
          ),
        );
        _nrcController.clear();
        _materiaController.clear();
        setState(() {

        });
      }
    else
      {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            duration: Duration(seconds: 2),
            content: Text('¡Error al agregar curso!'),
            backgroundColor: Colors.red,
          ));
        _nrcController.clear();
        _materiaController.clear();
        setState(() {

        });
      }
  }

  Future<void> eliminarCurso(int nrc, String profesor_id)async
  {
    bool deleted = await _service.eliminarCurso(nrc, profesor_id);
    if(deleted)
    {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          duration: Duration(seconds: 2),
          content: Text('Curso eliminado correctamente'),
          backgroundColor: Colors.blue,
        ),
      );
      setState(() {

      });
    }
    else
    {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            duration: Duration(seconds: 2),
            content: Text('¡Error al eliminar curso!'),
            backgroundColor: Colors.red,
          ));
      setState(() {

      });
    }

  }

  Future<void> openNewDialog(BuildContext context) async {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return AlertDialog(
            title: Text("Agregar Nuevo Curso"),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  width: 250,
                  height: 50,
                  child: TextField(
                    controller: _nrcController,
                    decoration: InputDecoration(labelText: "NRC",
                      border: OutlineInputBorder()),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                SizedBox(
                  width: 250,
                  height: 50,
                  child: TextField(
                    controller: _materiaController,
                    decoration: InputDecoration(labelText: "Materia",
                        border: OutlineInputBorder()),
                  ),
                ),
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
                    agregarCurso();
                    Navigator.of(context).pop();
                  },
                  child: Text("Agregar"))
            ],
          );
        }
    );
  }

  Future<void> openDeleteDialog(BuildContext context, int nrc, String profesor_id) async
  {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return AlertDialog(
            title: Text("Eliminar un Curso"),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text("Eliminar este curso, borrará todos los estudiantes y pruebas registrados. Estás seguro que deseas eliminar el curso: NRC $nrc?"),
              ],
            ),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text("Cancelar", style: TextStyle(
                    color: Colors.blue,
                    fontWeight: FontWeight.bold,
                  ),),),
              TextButton(
                  onPressed: () {
                    eliminarCurso(nrc, profesor_id);
                    Navigator.of(context).pop();
                  },
                  child: Text("Borrar Curso",
                    style: TextStyle(
                      color: Colors.red,
                      fontWeight: FontWeight.bold,
                    ),))
            ],
          );
        }
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Mis Cursos"),
      ),
      body: SafeArea(child: Center(
          child:
          FutureBuilder(future: _repository.getList(Provider
              .of<ProfesorProvider>(context)
              .user!
              .id),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                }
                if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return Center(child: Text('Aún no se han registrado cursos'));
                }
                if (snapshot.hasData) {
                  print(snapshot.data);
                  return ListView.builder(itemCount: snapshot.data?.length,
                    itemBuilder: (context, index) {
                      return CursoItem(curso: snapshot.data![index],
                          action: () {
                        context.go("/courses/${snapshot.data![index].nrc}/students",
                            extra: snapshot.data![index].nrc);
                          }, action2: () {
                            context.go("/courses/${snapshot.data![index].nrc}/tests",
                                extra: snapshot.data![index].nrc);
                          }, edit_action: () {
                        print("Editar curso");
                          }, delete_action: () {
                            openDeleteDialog(context, snapshot.data![index].nrc, snapshot.data![index].profesor_id);
                          });
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
          openNewDialog(context);
        },
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [Icon(Icons.add)],
        ),
      ),
    );
  }
}
