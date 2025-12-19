import 'package:flutter/material.dart';
class MyAppBar extends StatefulWidget implements PreferredSizeWidget{
  const MyAppBar({super.key});

  @override
  State<MyAppBar> createState() => _MyAppBarState();
  
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

  

class _MyAppBarState extends State<MyAppBar> {
  String title="Inicio";
  String page="home";
  @override void initState() {
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Theme.of(context).colorScheme.primary,
      foregroundColor: Theme.of(context).colorScheme.onPrimary,
      title: Text(title),
      actions: [
        IconButton(onPressed: (){
          Navigator.pushNamed(context, "/character_list");
          //El estado del appbar puede interferir
        }, icon: Icon(Icons.person_search_outlined)),
        IconButton(onPressed: (){
          Navigator.pushNamed(context, "/my_chars");
          //El estado del appbar puede interferir
        }, icon: Icon(Icons.supervised_user_circle_sharp))
      ],
    );
  }
}
