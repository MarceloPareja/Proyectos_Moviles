import 'package:estudio_p2_apis/desing_system/components/character_image.dart';
import 'package:estudio_p2_apis/desing_system/components/my_app_bar.dart';
import '../../services/database/firestore_db_service.dart';
import 'package:flutter/material.dart';
class CharacterEditPage extends StatefulWidget {
  const CharacterEditPage({super.key});

  @override
  State<CharacterEditPage> createState() => _CharacterEditPageState();
}

class _CharacterEditPageState extends State<CharacterEditPage> {
  late TextEditingController nameController=TextEditingController();
  late TextEditingController speciesController=TextEditingController();
  late TextEditingController planetController=TextEditingController();
  late Image character_image;
  Map<String, dynamic> args= {};

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    args=ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    nameController.text=args["name"];
    speciesController.text=args["species"];
    planetController.text=args["planet"];
    character_image=Image.network(args["image"]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(),
      body: Container(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surface,
            ),
            margin: EdgeInsets.all(10),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CharacterImage(image: character_image),
                SizedBox(height: 20,),
                TextField(
                  controller: nameController,
                  decoration: InputDecoration(
                      labelText: "Nombre"
                  ),
                ),
                SizedBox(height: 10),
                TextField(
                  controller: speciesController,
                  decoration: InputDecoration(
                      labelText: "Especie"
                  ),
                ),
                SizedBox(height: 10),
                TextField(
                  controller: planetController,
                  decoration: InputDecoration(
                      labelText: "Planeta"
                  ),
                ),
                SizedBox(height: 15,),
                ElevatedButton(onPressed: ()async{
                  bool res=await addCharacter(nameController.text, speciesController.text, planetController.text, args["image"]);
                  if(res)
                    {
                      Navigator.pushNamed(context, "/my_chars");
                    }
                  else{
                    print("No Guardado");
                  }
                }, child: Text("Guardar Cambios"))
              ],
            )
        )
      );
  }
}
