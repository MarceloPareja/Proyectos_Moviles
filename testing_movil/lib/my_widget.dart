import 'package:flutter/material.dart';
class MyWidget extends StatelessWidget {
  final String user;
  final String password;
  const MyWidget({super.key, required this.user, required this.password});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Column(
          children: [
            Text(user),
            Text(password)
          ],
        ),
      ),
    );
  }
}
