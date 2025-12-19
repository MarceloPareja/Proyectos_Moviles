import 'package:estudio_p2_apis/desing_system/components/my_app_bar.dart';
import 'package:flutter/foundation.dart';
import '../../domain/models/character.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
class ApiConsumerPage extends StatefulWidget {
  const ApiConsumerPage({super.key});

  @override
  State<ApiConsumerPage> createState() => _ApiConsumerPageState();
}

class _ApiConsumerPageState extends State<ApiConsumerPage> {
  final dio = Dio();//Instanciar el servicio
  final List<Character> characters=[];

  @override
  initState(){
    super.initState();
    getCharacters();
  }

  Future<void> getCharacters()async{
    List<Character> retrievedCharacters=[];
    String uri="https://api.sampleapis.com/futurama/characters/";
    Character? oneChar;
    Response res=await dio.get(uri);
    for(var element in res.data){
      oneChar=Character.fromJson(element);
      retrievedCharacters.add(oneChar);
      if(kDebugMode)
        {
          print(oneChar.toString());
        }
    }
    setState(() {
      characters.addAll(retrievedCharacters);
    });
    if(characters.length!=0)
      {
        print("Personajes obtenidos");
      }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(),
      body: Container(
        child: Center(
          child: ListView.builder(
              itemCount: characters.length,
              itemBuilder: (context,index){
                if(characters.isNotEmpty)
                  {
                    return Card(
                      child: ListTile(
                        leading: SizedBox(width: 40, height: 40,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: Image.network(characters[index].images.main,
                              ),
                          ),),
                        title: Text("${characters[index].name.first} ${characters[index].name.middle} `${characters[index].name.last}"),
                        subtitle: Text(characters[index].species),
                        onTap: (){
                            Map <String, dynamic> args={
                              "name": "${characters[index].name.first} ${characters[index].name.middle} `${characters[index].name.last}",
                              "species": characters[index].species,
                              "planet": characters[index].homePlanet,
                              "image": characters[index].images.main
                            };
                            Navigator.pushNamed(context, "/edit", arguments: args);
                        },
                      ),
                    );
                  }
                else
                  {
                    return CircularProgressIndicator();
                  }
              }
          )
        ),
      )
    );
  }
}
