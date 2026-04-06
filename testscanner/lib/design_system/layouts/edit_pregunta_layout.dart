import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../data/remote_repositories/pregunta_repository.dart';
import '../../domain/entities/pregunta.dart';
class EditPreguntaLayout extends StatefulWidget {
  final String prueba_id;
  final int curso_id;
  final String pregunta_id;
  EditPreguntaLayout({super.key, required this.prueba_id,
    required this.pregunta_id,
  required this.curso_id});

  @override
  State<EditPreguntaLayout> createState() => _EditPreguntaLayoutState();
}

class _EditPreguntaLayoutState extends State<EditPreguntaLayout> {
  TextEditingController _enunciadoController=TextEditingController();
  TextEditingController _valorController=TextEditingController();
  TextEditingController _respuestasController=TextEditingController();
  late Pregunta _pregunta;
   PreguntaRepository _repository=PreguntaRepository();
   bool _loading=false;
   String _errorMsg="";

   void _getPregunta() async {
     Pregunta pregunta = await _repository.getById(_pregunta.id, widget.prueba_id);
   }

  Future<void> _guardarCambios() async
  {
    if(!validateData())
      {
        print("Error");
        return;
      }

    _pregunta.enunciado=_enunciadoController.text;
    _pregunta.valor=int.parse(_valorController.text);

    bool success = await _repository.update(_pregunta);
    if(success)
    {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          duration: Duration(seconds: 2),
          content: Text("Datos de la pregunta actualizados"),
          backgroundColor: Colors.green,
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
            content: Text('Error al actualizar los datos'),
            backgroundColor: Colors.red,
          ));
    }
  }
  @override
  void initState() {
     _loading=true;
     _getPregunta();
     setState(() {
       _loading=false;
     });
    super.initState();
  }

  bool validateData(){
     if(_enunciadoController.text==""||_valorController.text=="")
       {
         setState(() {
           _errorMsg="No debe dejar campos vacíos";
         });
         return false;
       }
     if(int.tryParse(_valorController.text)==null)
       {
         setState(() {
           _errorMsg = "El valor debe ser un número entero";
         });
         return false;
       }
     if(int.parse(_valorController.text)<0 || int.parse(_valorController.text)==0)
       {
         setState(() {
           _errorMsg="El valor debe ser mayor a 0";
         });
         return false;
       }
     return true;
  }
  @override void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    final data = GoRouterState.of(context).extra as Pregunta;
    _pregunta=data;
    _enunciadoController.text=_pregunta.enunciado;
    _valorController.text=_pregunta.valor.toString();
    super.didChangeDependencies();
  }
  @override
  Widget build(BuildContext context) {
    return (_loading) ? (PopScope(
      onPopInvoked: (didPop) {
        if(didPop) return;
        context.go("/courses/${widget.curso_id}/tests/${widget.prueba_id}/questions");
      },
      child: Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      ),
    )) :
    (PopScope(
      onPopInvoked: (didPop) {
        if(didPop) return;
        context.go("/courses/${widget.curso_id}/tests/${widget.prueba_id}/questions");
      },
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: Text("Editar Pregunta")),
          body: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: 10,
                ),
                TextField(
                  controller: _enunciadoController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Enunciado",
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                TextField(
                  controller: _valorController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Valor",
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(_errorMsg,
                  style: TextStyle(color: Colors.red),
                ),
                SizedBox(
                  height: 10,
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
                          context.go("/courses/${widget.curso_id}/tests/${widget.prueba_id}/questions");
                        }, child: Text("Cancelar")),
                        OutlinedButton(onPressed: (){
                          _guardarCambios();
                        }, child: Text("Actualizar")),
                      ],
                    )
                )
              ],
          ),
            )),
      )));
  }
}
