import 'package:flutter/material.dart';
class ResponseText extends StatelessWidget {
  final String text;
  final Color? color;
  const ResponseText({super.key, required this.text,
  required this.color});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      spacing: 10,
      children: [
        Container(
          height: 30,
          child: Text("Resultado:", textAlign: TextAlign.left, style: TextStyle(fontWeight: FontWeight.bold),),
        ),
        Container(
          padding: EdgeInsets.all(10),
          color: Colors.blue[50],
          height: 40,
          child: Text(text, style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.blue[900]
          ),textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }
}
