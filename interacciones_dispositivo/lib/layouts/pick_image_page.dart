import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
class PickImagePage extends StatefulWidget {
  const PickImagePage({super.key});

  @override
  State<PickImagePage> createState() => _PickImagePageState();
}

class _PickImagePageState extends State<PickImagePage> {
  File? _image;
  final _picker=ImagePicker();

  pickImage() async {
    final picketFile = await _picker.pickImage(source: ImageSource.gallery);
    if (picketFile != null) {
      _image = File(picketFile.path);
      setState(() {

      });
    }
  }
    takePhoto() async{
      final picketFile = await _picker.pickImage(source: ImageSource.gallery);
      if(picketFile != null){
        _image = File(picketFile.path);
        setState(() {

        });
      }
    }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pick an Image'),
      ),
      body: Center(
        child:
        _image == null
            ? Text('No image selected.')
            : Image.file(_image!),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: () {
              pickImage();
            },
            child: const Icon(Icons.photo_album),
          ),
          FloatingActionButton(
            onPressed: () {
              takePhoto();
            },
            child: const Icon(Icons.image),
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
