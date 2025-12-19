import 'package:exam_2_pareja/presentacion/design_system/components/my_app_bar.dart';
import 'package:flutter/material.dart';
import '../../../datos/repository_impl.dart';
class AddPage extends StatefulWidget {
  const AddPage({super.key});

  @override
  State<AddPage> createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {
  TextEditingController usernameControl=TextEditingController();
  TextEditingController passwordControl=TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(),
      body: Container(
        child: Column(
          children: [
            Text("Agregar Usuario", style: TextStyle(fontWeight: FontWeight.bold),),
            SizedBox(height: 20),
            SizedBox(width: 170,
            child: TextField(
              controller: usernameControl,
              decoration: InputDecoration(
                  labelText: "Uusario"
              ),
            ),),
            SizedBox(height: 20),
            SizedBox(width: 170,
              child: TextField(
                controller: passwordControl,
                decoration: InputDecoration(
                    labelText: "Clave"
                ),
              ),),
            SizedBox(height: 10,),
            ElevatedButton(onPressed: ()async{
              bool added=await RepositoryImpl().addUser(usernameControl.text, passwordControl.text);
              if(added)
                {
                  Navigator.pushNamed(context, "/");
                }
              else
                {
                  print("No se ha agregado");
                }
            }, child: Text("Agregar"))
          ],
      ),
    )
    );
  }
}
