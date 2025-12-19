import 'package:flutter/material.dart';
import '../services/firebase_services.dart';
class Updatepage extends StatefulWidget {
  const Updatepage({super.key});
  @override
  State<Updatepage> createState() => _UpdatepageState();
}

class _UpdatepageState extends State<Updatepage> {
  late TextEditingController namecontro = TextEditingController();
  late TextEditingController mailcontro = TextEditingController();
  late TextEditingController uidcontro = TextEditingController();
  Map<String,dynamic> arguments = {};
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    arguments = ModalRoute
        .of(context)!
        .settings
        .arguments as Map<String, dynamic>;
    uidcontro = TextEditingController(text: arguments['uid']);
    namecontro = TextEditingController(text: arguments['name']);
    mailcontro = TextEditingController(text: arguments['email']);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Fluter+Firebase"),
      ),
      body: Column(
        children: [
          const SizedBox(height: 15,),
          TextField(controller: uidcontro,
              keyboardType: TextInputType.text,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: "Uid",
              )
          ),
          const SizedBox(height: 10,)
          ,
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
            bool res = await updateUser(uidcontro.text, namecontro.text, mailcontro.text);
            if(res){
              Navigator.pushNamed(context, '/home');
            }else{
              SnackBar(content: Text("No se pudo guardar"),);
            }
          },child: Text("Actualizar"),)
        ],
      ),
    );
  }
}