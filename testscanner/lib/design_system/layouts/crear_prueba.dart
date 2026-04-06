import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:testscanner/data/services/prueba_service.dart';
import '../../data/remote_repositories/prueba_repository.dart';
import '../../domain/entities/prueba.dart';
class CrearPrueba extends StatefulWidget {
  final int curso;
  const CrearPrueba({super.key,
    required this.curso,
  });

  @override
  State<CrearPrueba> createState() => _CrearPruebaState();
}

class _CrearPruebaState extends State<CrearPrueba> {
  TextEditingController _tituloController = TextEditingController();
  TextEditingController _fechaController = TextEditingController();
  TextEditingController _instruccionesController = TextEditingController();
  final PruebaRepository _repository = PruebaRepository();
  final PruebaService _service = PruebaService();
  DateTime? selectedDate;

  @override
  void initState() {
    _fechaController.text = "dd/mm/aaaa";
    super.initState();
  }


  Future<void> _openQuestionsDialog(BuildContext context) async
  {
    String prueba_id = await _service.getLastId(widget.curso);
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return AlertDialog(
            title: Text("Agregar preguntas"),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text("La prueba creada aún no tiene preguntas. Desea agregar preguntas?"),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  context.go("/courses/${widget.curso}/tests");
                },
                child: Text("Más tarde", style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),),),
              TextButton(
                  onPressed: () async {
                    Navigator.of(context).pop();
                    context.go("/courses/${widget.curso}/tests/${prueba_id}/questions/add", extra: prueba_id);
                  },
                  child: Text("Agregar",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),))
            ],
          );
        }
    );
  }

  Future<void> _agregarCurso() async
  {
    String titulo=_tituloController.text;
    DateTime fecha=selectedDate!;
    String instrucciones=_instruccionesController.text;
    int nrc=widget.curso;

    bool success = await _repository.crearPrueba(titulo, fecha, nrc, instrucciones);
    if(success)
    {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          duration: Duration(seconds: 2),
          content: Text('¡Prueba agregada exitosamente!'),
          backgroundColor: Colors.green,
        ),
      );
      _tituloController.clear();
      _instruccionesController.clear();
      _fechaController.clear();
      _openQuestionsDialog(context);
    }
    else
    {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            duration: Duration(seconds: 2),
            content: Text('¡Error al agregar curso!'),
            backgroundColor: Colors.red,
          ));
    }
  }
  Future<void> _selectDate() async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      firstDate: DateTime(DateTime.now().day, DateTime.now().month, DateTime.now().year),
      initialDate: selectedDate ?? DateTime.now(),
      lastDate: DateTime(DateTime.now().year + 1),
    );

    setState(() {
      selectedDate = pickedDate;
      _fechaController.text = selectedDate.toString().substring(0, 10);
    });
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
        canPop: false,
        onPopInvoked: (didPop) {
          if(didPop) return;

          context.go("/courses/${widget.curso}/tests");
          },
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text("Crear Prueba", style: TextStyle(fontSize: 20), textAlign: TextAlign.center),
          automaticallyImplyLeading: false,
        ),
        body: SafeArea(child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(
                  height: 10,
                ),
                SizedBox(width: 250,
                  height: 50,
                  child: TextField(
                      controller: _tituloController,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: "Titulo de la prueba",
                          hintText: "Ej: Leccion Parcial 2"
                      ))),
                  SizedBox(height: 40),
                  SizedBox(
                      width: 250,
                    height: 50,
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Expanded(
                            child: TextField(
                              readOnly: true,
                                controller: _fechaController,
                                decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                    labelText: "Fecha de la prueba")
                            ),
                          ),
                          IconButton(icon: Icon(Icons.calendar_month), onPressed: (){
                            _selectDate();
                          },)
                        ],
                      )
                  ),
                SizedBox(height: 40),
                SingleChildScrollView(
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      maxHeight: 150,
                      maxWidth: 250,
                      minWidth: 250,
                      minHeight: 100,
                    ),
                    child: Container(
                      child: TextField(
                        textAlignVertical: TextAlignVertical.top,
                          controller: _instruccionesController,
                          maxLines: null,
                          keyboardType: TextInputType.multiline,
                          showCursor: true,
                          expands: true,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: "Instrucciones de la prueba",)
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 100),
                SizedBox(
                  width: 250,
                  height: 50,
                   child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      spacing: 15,
                      children: [
                        OutlinedButton(onPressed: (){
                          context.go("/courses/${widget.curso}/tests");
                        }, child: Text("Cancelar")),
                        OutlinedButton(onPressed: (){
                          _agregarCurso();
                        }, child: Text("Crear")),
                      ],
                    )
                )
              ],
            ),
          ),
        )),
      ),
    );
  }
}
