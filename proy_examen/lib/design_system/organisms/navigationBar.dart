import 'package:flutter/material.dart';
class SwitchBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final List<IconButton> options;

  const SwitchBar({super.key, required this.title, required this.options});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(title),
      actions: options,
    );
  }
}
