import 'package:flutter/material.dart';
class EditPage extends StatelessWidget {
  const EditPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(20),
      child: Column(
        spacing: 20,
        children: [
          Text("Editar Datos", style: TextStyle(
            fontSize: 20
          ),),
          TextField(
            decoration: InputDecoration(
              labelText: "Nombre",
            ),
          ),
          ElevatedButton(onPressed: (){}, child: Text("Guardar Cambios"))
        ],
      ),
    );
  }
}
