import 'package:flutter/material.dart';
class CharacterImage extends StatelessWidget {
  final Image image;
  const CharacterImage({super.key, required this.image});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 60,
        width: 60,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(30),
          child: image,
        )
    );
  }
}
