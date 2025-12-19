import 'package:flutter/material.dart';
class MyAppBar extends StatefulWidget implements PreferredSizeWidget{
  const MyAppBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  State<MyAppBar> createState() => _MyAppBarState();
}

class _MyAppBarState extends State<MyAppBar> {
  String title="";
  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Theme.of(context).colorScheme.primary,
      foregroundColor: Theme.of(context).colorScheme.onPrimary,
      title: Text("App Sensores"),
      actions: [
        IconButton(
          icon: const Icon(Icons.image),
          onPressed: (){Navigator.pushNamed(context, "/photos");}),
        IconButton(
            icon: const Icon(Icons.sensors),
            onPressed: (){Navigator.pushNamed(context, "/sensors");}),
        IconButton(
            icon: const Icon(Icons.compass_calibration),
            onPressed: (){Navigator.pushNamed(context, "/compass");}),
      ],
    );
  }
}
