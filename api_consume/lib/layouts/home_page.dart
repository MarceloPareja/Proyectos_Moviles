import '';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

import '../Structure/models/pokemon.dart';


class Home_page extends StatefulWidget {
  const Home_page({super.key});

  @override
  State<Home_page> createState() => _Home_pageState();
}

class _Home_pageState extends State<Home_page> {
  dynamic pokemon;
  final int index=10;
  final List<Pokemon> pokemons= [];
  final dio = Dio();
  @override
  void initState() { //ejecuta puntero super, esto se ejecuta primero y consume apis por ejemplo
    get_api();
    super.initState();
  }

  Future<void> get_api() async{

      String uri = "https://pokeapi.co/api/v2/pokemon/1";
      final response  = await dio.get(uri);
      pokemon=Pokemon.fromJson(response.data);

  }

  Future<void> get_pokemones() async
  {
    final uri="https://pokeapi.co/api/v2/";
    Pokemon? pokemon;
    for(int i=1;i<=10;i++)
      {
        final response=await dio.get(uri+"pokemon/$i");
        final pokemon=Pokemon.fromJson(response.data);
        pokemons.add(pokemon);
      }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Pagina Principal"),),
        body: Text(pokemon.toString() ?? "no hay")

    );
  }
}