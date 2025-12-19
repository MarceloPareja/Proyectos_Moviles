import 'package:flutter/material.dart';

import '../components/my_app_bar.dart';
class SensorsPage extends StatefulWidget {
  const SensorsPage({super.key});

  @override
  State<SensorsPage> createState() => _SensorsPageState();
}

class _SensorsPageState extends State<SensorsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: MyAppBar(),
        body: Container(
          margin: EdgeInsets.all(20),
          child: Center(
            child: Text("Brujula"),
          ),
        )
    );
  }
}
