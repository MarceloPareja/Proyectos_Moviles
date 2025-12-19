import 'package:proy_examen/design_system/atoms/ActionButton.dart';
import 'package:flutter/material.dart';
class ButtonGroup extends StatelessWidget {
  final List<ActionButton> buttons;
  const ButtonGroup({super.key, required this.buttons});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          spacing: 20,
          children: [
            ActionButton(label: buttons[0].label,action:  buttons[0].action),
            ActionButton(label: buttons[1].label,action:  buttons[1].action),
          ],
        ),
        Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          spacing: 20,
          children: [
            ActionButton(label: buttons[2].label,action:  buttons[2].action),
            ActionButton(label: buttons[3].label,action:  buttons[3].action),
          ],
        )
      ],
    );
  }
}
