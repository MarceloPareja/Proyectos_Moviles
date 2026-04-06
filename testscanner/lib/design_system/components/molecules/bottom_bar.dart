import 'package:flutter/material.dart';
import "package:go_router/go_router.dart";
import '../atoms/page_button.dart';

class BottomBar extends StatelessWidget {
  //final templateColors colors;
  final StatefulNavigationShell navigationShell;

  const BottomBar({
    super.key,
    //required this.colors,
    required this.navigationShell,
  });

  void _goBranch(int index) {
    navigationShell.goBranch(
      index,
      initialLocation: index == navigationShell.currentIndex,
    );
  }

  @override
  Widget build(BuildContext context) {

    return Container(
      margin: const EdgeInsets.fromLTRB(0, 8, 0, 0),
      padding: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        color: ColorScheme.of(context).secondary,
        boxShadow: [
          BoxShadow(
            color: Colors.blueGrey.withOpacity(0.2),
            blurRadius: 8,
            offset: const Offset(0, 2),
          )
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          const SizedBox(width: 10),
          Expanded(
            child: PageButton(
              text: "Cursos",
              icon: Icons.book_outlined,
              onPressed: () => _goBranch(0),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: PageButton(
              text: "Calificar",
              icon: Icons.document_scanner_outlined,
              onPressed: () => _goBranch(1),
            ),
          ),
          const SizedBox(width: 10),
          const SizedBox(width: 10),
        ],
      ),
    );
  }
}