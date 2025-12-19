import 'package:flutter/material.dart';
import 'dart:math';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

import '../components/my_app_bar.dart';
class PhotoUsagePage extends StatefulWidget {
  const PhotoUsagePage({super.key});

  @override
  State<PhotoUsagePage> createState() => _PhotoUsagePageState();
}

class _PhotoUsagePageState extends State<PhotoUsagePage> {
  File? _image;
  final ImagePicker _picker = ImagePicker();
  final rotateDegree=90;

   _getImage() async {
    final pickedImage=await _picker.pickImage(source: ImageSource.gallery);
    if(pickedImage!=null){
      setState(() {
        _image=File(pickedImage.path);
      });
    }
  }

  takePhoto() async{
    final pickedImage=await _picker.pickImage(source: ImageSource.camera);
    if(pickedImage!=null){
      setState(() {
        _image=File(pickedImage.path);
      });
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: MyAppBar(),
        body: Container(
          margin: EdgeInsets.all(20),
          child: Center(
            child: SizedBox(height: 140,width: 140,
            child:ClipRRect(
              borderRadius: BorderRadiusGeometry.circular(20),
              child: Transform.rotate(angle: pi/180*rotateDegree,
                child: Container(
                alignment: Alignment.center,
                child: Image.file(_image ?? File("")),
              ),
            ),
            ),
          ),
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
