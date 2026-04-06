import 'package:flutter/material.dart';
class ListWidget extends StatelessWidget {
  const ListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("Mi pagina"),
          actions: [
            IconButton(onPressed: (){}, icon: Icon(Icons.add_a_photo)),
            IconButton(onPressed: (){}, icon: Icon(Icons.call)),
            IconButton(onPressed: (){}, icon: Icon(Icons.person_add))
          ],
        )
      ),
    );
  }
}
