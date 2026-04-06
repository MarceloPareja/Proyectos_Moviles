import 'package:flutter/material.dart';
import '../atoms/menu_item.dart';

class DropdownMenu extends StatefulWidget {
  final VoidCallback edit;
  final VoidCallback delete;
  const DropdownMenu({super.key,
  required this.edit,
  required this.delete});

  @override
  State<DropdownMenu> createState() => _DropdownMenuState();
}

class _DropdownMenuState extends State<DropdownMenu> {
  int? selectedItem;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        boxShadow: [
          BoxShadow(
              color: Colors.grey,
              offset: new Offset(2.0,2.0),
              spreadRadius: 0.25,
              blurRadius: 2.5
          )
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(5),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            GestureDetector(
                onTap: () {
                  setState(() {
                    selectedItem=1;
                  });
                  widget.edit;
                },
                child: MenuItem(label: "Editar")
            ),
            GestureDetector(
                onTap: () {
                  setState(() {
                    selectedItem=2;
                  });
                  widget.delete;
                },
                child: MenuItem(label: "Eliminar")
            ),
          ],
        ),
      ),
    );
  }
}