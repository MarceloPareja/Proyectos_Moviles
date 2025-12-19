import 'package:flutter/material.dart';
class myNavigationBar extends StatefulWidget implements PreferredSizeWidget{
  const myNavigationBar({super.key});

  @override
  State<myNavigationBar> createState() => _myNavigationBarState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _myNavigationBarState extends State<myNavigationBar> {
  String _title = "";

  @override void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      _title="Notificación instantánea";
    });
  }
  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Theme.of(context).colorScheme.primary,
      foregroundColor: Theme.of(context).colorScheme.onPrimary,
      title: Text(_title),
      actions: [
        IconButton(onPressed: (){
          setState(() {
            _title="Notificación instantánea";
          });
          Navigator.pushNamed(context, "/instant");
        }, icon: Icon(Icons.notification_add)),
        IconButton(onPressed: (){
          setState(() {
            _title="Notificación programada";
          });
          Navigator.pushNamed(context, "/scheduled");
        }, icon: Icon(Icons.edit_notifications_outlined)),
      ],
    );
  }
}
