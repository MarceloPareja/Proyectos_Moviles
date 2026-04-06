import 'package:go_router/go_router.dart';

import '../../data/remote_repositories/prueba_repository.dart';
import '../../design_system/components/atoms/tile_option.dart';

import '../../data/remote_repositories/estudiante_repository.dart';
import '../../domain/entities/estudiante.dart';
import '../../domain/entities/pregunta.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'dart:math';
import 'package:permission_handler/permission_handler.dart';
import '../../domain/services/gemini_ai_service.dart';
import '../../domain/services/test_grader.dart';
class PhotoLayout extends StatefulWidget {
  const PhotoLayout({super.key});

  @override
  State<PhotoLayout> createState() => _PhotoLayoutState();
}

class _PhotoLayoutState extends State<PhotoLayout> {
  final _ai_service=GeminiAiService();
  final _grader=TestGrader();
  final _estudianteRepository = EstudianteRepository();
  final _pruebaRepository = PruebaRepository();
  File? _image;
  final ImagePicker _picker = ImagePicker();
  final rotateDegree=90;
  late Map<String, dynamic> results;
  bool _scanning=false;

  Future<Map<String, dynamic>> _getScanResults ()async{
      results=await _ai_service.getTestResults(_image!);
      return results;
  }

  _getImage() async {
    if(await Permission.photos.request().isGranted)
      {
        final pickedImage=await _picker.pickImage(source: ImageSource.gallery);
        if(pickedImage!=null){
          setState(() {
            _image=File(pickedImage.path);
          });
        }
      }
  }
  takePhoto() async{
    if(await Permission.camera .request().isGranted)
    {
      final pickedImage=await _picker.pickImage(source: ImageSource.camera);
      if(pickedImage!=null){
        setState(() {
          _image=File(pickedImage.path);
        });
      }
    }
  }

  void openUploadDialog(BuildContext context) async
  {
    return showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) {
        return AlertDialog(
            title: Text("Subir Imagen"),
            content: Row(
                mainAxisSize: MainAxisSize.min,
                spacing: 15,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TileOption(icon: Icons.camera_alt_outlined,
                      label: "Cámara",
                      action: () {
                        takePhoto();
                        context.pop();
                      }),
                  TileOption(icon: Icons.photo,
                      label: "Galería",
                      action: () {
                        _getImage();
                        context.pop();
                      }),
                ]

            )
        );
      });
  }

  void _gradeAndShow() async{
    try{
      setState(() {
        _scanning=true;
      });
      Map<String,dynamic> testData = await _getScanResults();
      List<Estudiante> estudiantes = await _estudianteRepository.getList(testData["nrc"]);
      String? closestStudent = await _ai_service.getClosestStudent(testData["name"], estudiantes);
      String prueba_id = await _pruebaRepository.getIdByDataCombination(testData["title"], testData["date"], testData["nrc"]);
      await _grader.gradeTest(prueba_id, results, closestStudent!);
      setState(() {
        _scanning=false;
      });
      context.go("/courses/${testData["nrc"]}/tests/${prueba_id}/graded");
    }
    catch(e)
    {
      print(e);
      setState(() {
        _scanning=false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          duration: Duration(seconds: 2),
          content: Text('Error al escanear'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    _image=null;
    _scanning=false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return (_scanning) ? (Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    )) :
      (Scaffold(
        appBar: AppBar(
        title: Text("Escanear y calificar"),
      ),
      body: Container(
        margin: EdgeInsets.all(20),
        child: Center(
          child: Column(
            spacing: 20,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text((_image != null) ? "Imagen Lista" : "No se ha cargado una imagen"),
              OutlinedButton(onPressed: (){
                openUploadDialog(context);
              }, child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                spacing: 2,
                children: [
                  Text("Cargar Imagen"),
                  Icon(Icons.upload_outlined)
                ],
              )
              ),
              ElevatedButton(onPressed: (){
                if(_image!=null && !_scanning){
                  _gradeAndShow();
                }
                }, child: Text((_image != null) ? "Escanear" : "Escanear") ,
                  style: ButtonStyle(
                    backgroundColor: (_image != null) ? MaterialStateProperty.all(Colors.blue) : MaterialStateProperty.all(Colors.grey[200]),
                    foregroundColor: (_image != null) ? MaterialStateProperty.all(Colors.white) : MaterialStateProperty.all(Colors.grey[700]),
                  )
              )
            ],
          )
        ),
      )
    ));
  }
}
