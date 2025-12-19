import 'dart:io';

import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:pareja_marcelo_testp2/presentation/components/my_app_bar.dart';
import '../../models/character.dart';
class FullListPage extends StatefulWidget {
  const FullListPage({super.key});

  @override
  State<FullListPage> createState() => _FullListPageState();
}

class _FullListPageState extends State<FullListPage> {
  final List<Character> characters=[];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCharacters();
  }

  Future<List<Character>> fetchCharacters() async{
    final dio=Dio();
    final response=await dio.get("api.sampleapis.com/futurama/characters/");
    if(response.data)
      {
        final List<dynamic> data=response.data;
        print("Se recupero contenido");
        return data.map((e) => Character.fromJson(e)).toList();
      }
    else
      {
        throw Exception('Failed to load characters');
      }
  }

  void getCharacters() async
  {
      final List<Character> apiData = await fetchCharacters();
      apiData.forEach((char){
        characters.add(char);
      });
      print("Se recibieron datos");
      print(characters[0].toString());
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(),
      body: Container(
        color: Theme.of(context).colorScheme.surface,
        child: Center(
          child: ListView.builder(itemCount: characters.length,
              itemBuilder: (context,index)
              {
                final character = characters[index];
                return ListTile(
                  leading: Image.network(character.images.main),
                  title: Text("${character.name.first} ${character.name.last}"),
                  subtitle: Text(character.occupation),
                );
              }
          ),
        )
      ),
    );
  }
}
