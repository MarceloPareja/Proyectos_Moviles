import 'package:flutter/material.dart';
import 'package:pareja_marcelo_testp2/presentation/components/my_app_bar.dart';
class BdListPage extends StatefulWidget {
  const BdListPage({super.key});

  @override
  State<BdListPage> createState() => _BdListPageState();
}

class _BdListPageState extends State<BdListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: MyAppBar(),
        body: Container(
          color: Theme
              .of(context)
              .colorScheme
              .surface,
          child: Center(
            child: Text("personajes en bd"),
          ),
        )
    );
  }
}