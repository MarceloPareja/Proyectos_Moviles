import 'package:flutter/material.dart';
import '../atoms/tile_option.dart';
class BasicListItem extends StatelessWidget {
  final String text;
  BasicListItem({super.key, required this.text
  });
  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        contentPadding: EdgeInsets.all(5),
        leading: SizedBox(
          width: 300,
          child: Text(text,
            style: TextStyle(fontWeight: FontWeight.bold,
                fontSize: 14),),
        ),
      )
    );
  }
}