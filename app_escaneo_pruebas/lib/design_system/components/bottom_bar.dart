import 'package:flutter/material.dart';
import "package:go_router/go_router.dart";
import 'page_button.dart';

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
      margin: const EdgeInsets.all(8),
      padding: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        color: ColorScheme.of(context).secondary,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(10),
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
              text: "Pruebas",
              icon: Icons.library_books_outlined,
              onPressed: () => _goBranch(1),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: PageButton(
              text: "Perfil",
              icon: Icons.person_outline,
              onPressed: () => _goBranch(2),
            ),
          ),
          const SizedBox(width: 10),
        ],
      ),
    );
  }
}