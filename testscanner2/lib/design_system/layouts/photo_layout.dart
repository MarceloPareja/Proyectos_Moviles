import 'package:app_escaneo_pruebas/domain/entities/pregunta.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'dart:math';
import 'package:permission_handler/permission_handler.dart';
import '../../domain/services/gemini_ai_service.dart';
class PhotoLayout extends StatefulWidget {
  const PhotoLayout({super.key});

  @override
  State<PhotoLayout> createState() => _PhotoLayoutState();
}

class _PhotoLayoutState extends State<PhotoLayout> {
  final _ai_service=GeminiAiService();
  File? _image;
  final ImagePicker _picker = ImagePicker();
  final rotateDegree=90;
  late Map<String, dynamic> results;

  void _getScanResults ()async{
      results=await _ai_service.getTestResults(_image!);
      print(results);
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Imagenes"),
      ),
      body: Container(
        margin: EdgeInsets.all(20),
        child: Center(
          child: Column(
            spacing: 20,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Card(
                child: Text(_image?.path ?? "No se ha cargado un archivo"),
              ),
              ElevatedButton(onPressed: ()async{
                if(_image!=null){
                  _getScanResults();
                }
                else{
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text("No se ha cargado una imagen"),
                    ));
              }
                }, child: Text("Obtener resultados"),
              )
            ],
          )
        ),
      ),
      floatingActionButton:
      Row(
        spacing: 10,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          FloatingActionButton(onPressed: (){_getImage();},
            child: Icon(Icons.photo_album_outlined),
          ),
          FloatingActionButton(onPressed: (){takePhoto();},
            child: Icon(Icons.camera_alt_outlined),
          ),
        ],
      ),
    );
  }
}
