import 'package:flutter/material.dart';

class NumberInput extends StatefulWidget {
  final Function(String) action;
  final String inputLabel;

  const NumberInput({super.key, required this.action, required this.inputLabel});

  @override
  State<NumberInput> createState() => _NumberInputState();
}

class _NumberInputState extends State<NumberInput> {
  late TextEditingController _controller;
  String? _errorText;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: '0');
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _validate(String value) {
    setState(() {
      if (value.isEmpty || num.tryParse(value) == null) {
        _errorText = 'Please enter a valid number';
      } else {
        _errorText = null;
        widget.action(value);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      color: Colors.grey[200],
      child: TextField(
        controller: _controller,
        decoration: InputDecoration(
          fillColor: Colors.grey[100],
          label: Text(widget.inputLabel),
          errorText: _errorText,
        ),
        onChanged: _validate,
      ),
    );
  }
}
