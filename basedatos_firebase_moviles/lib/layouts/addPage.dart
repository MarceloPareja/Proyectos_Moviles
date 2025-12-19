import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../services/firebase_services.dart';
class Addpage extends StatefulWidget {
  const Addpage({super.key});

  @override
  State<Addpage> createState() => _AddpageState();
}

class _AddpageState extends State<Addpage> {
  TextEditingController namecontro = TextEditingController();
  TextEditingController mailcontro = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Fluter+Firebase"),
        actions: [
          IconButton(onPressed: (){
            Navigator.pushNamed(context, '/add');
          }, icon: Icon(Icons.add)),
          IconButton(onPressed: (){
            Navigator.pushNamed(context, '/home');
          }, icon: Icon(Icons.home))
        ],
      ),
      body: Column(
        children: [
          TextField(controller: namecontro,
            keyboardType: TextInputType.text,
            decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: "Nombre",
                hint: Text("Ingresa un nombre")
            ),
          ),
          const SizedBox(height: 10,)
          ,
          TextField(controller: mailcontro,
            keyboardType: TextInputType.text,
            decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: "Email",
                hint: Text("Ingresa un e-mail")
            ),
          ),
          const SizedBox(height: 10,),
          ElevatedButton(onPressed: ()async{
            bool res = await putUser(namecontro.text, mailcontro.text);
            if(res){
              Navigator.pushNamed(context, '/home');
            }else{
              SnackBar(content: Text("No se pudo guardar"),);
            }
          },child: Text("Ingresar"),)
        ],
      ),
    );
  }
}