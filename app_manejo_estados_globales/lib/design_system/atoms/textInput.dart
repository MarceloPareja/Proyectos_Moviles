import 'package:flutter/material.dart';

/*Este widget sirve para el ingreso de texto*/

class textInput extends StatefulWidget {
  final String label;
  final Function(String) action;
  const textInput({super.key,
    required this.label,
    required this.action
  });

  @override
  State<textInput> createState() => _textInputState();
}

class _textInputState extends State<textInput> {
  final t_controller=TextEditingController();
  String value="";
  bool is_empty=false;

  @override
  void initState()
  {
    super.initState();
    t_controller.addListener(validate_empty_input);
    t_controller.clear();
  }

  void validate_empty_input()
  {
    final text=t_controller.text;
    if(text.isEmpty)
    {
      setState(() {
        is_empty=true;
      });
    }
    else
    {
      setState(() {
        is_empty=false;
        value=text;
      });
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    t_controller.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      child:
      TextField(
        controller: t_controller,
        onChanged: widget.action,
        decoration: InputDecoration(
          labelText: widget.label,
          border: UnderlineInputBorder(),
          errorBorder: UnderlineInputBorder(),
          focusColor: Colors.blue,
        ),
      ),
    );
  }
}
