import 'package:flutter/material.dart';
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return
      Scaffold(
        appBar: AppBar(
          title: Text("Uso de sensores y fotos"),
        ),
        body: Center(
          child: Column(
            children: [
              ElevatedButton(onPressed: (){Navigator.pushNamed(context, "/fotos");}, child:
              Text("Fotos")),
              ElevatedButton(onPressed: (){Navigator.pushNamed(context,"/sensor");}, child:
              Text("Fotos")),
              ElevatedButton(onPressed: (){Navigator.pushNamed(context,"/compass");}, child:
              Text("Fotos")),
            ],
          ),
        ),
      );
  }
}
