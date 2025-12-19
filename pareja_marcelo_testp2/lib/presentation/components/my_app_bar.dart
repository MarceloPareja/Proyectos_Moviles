import 'package:flutter/material.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  const MyAppBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Theme.of(context).colorScheme.primary,
      foregroundColor: Theme.of(context).colorScheme.onPrimary,
      title: const Text("Futurama API"),
      actions: [
        IconButton(onPressed: (){
          Navigator.pushNamed(context, "/Characters");
        }, icon: Icon(Icons.supervised_user_circle_outlined)),
        IconButton(onPressed: (){
          Navigator.pushNamed(context, "/myCharacters");
        }, icon: Icon(Icons.people_outline))
      ],
    );
  }
}
