import 'package:flutter/material.dart';

/*Este widget sirve para el ingreso de una contraseña
 o texto escondido*/

class passwordInput extends StatefulWidget {
  final Function(String) action;
  const passwordInput({super.key,
  required this.action
  });


  @override
  State<passwordInput> createState() => _passwordInputState();
}


class _passwordInputState extends State<passwordInput> {
  final t_controller=TextEditingController();//Controlador de texto
  String value="";
  bool is_empty=true;

  @override
  void initState()
  {
    super.initState();
    //El controlador se conecta a la función
    t_controller.addListener(validate_empty_input);
    t_controller.clear();
  }

  void validate_empty_input()//Esta función valida si está vacío
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
    //Esta función desconecta al controlador
    super.dispose();
    t_controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      child:
      TextField(
        //La propiedad obscureText permite mostrar el input como texto protegido
        obscureText: true,
        controller: t_controller,
        onChanged: widget.action,
        decoration: InputDecoration(
          labelText: "Contraseña",
          border: UnderlineInputBorder(),
          focusColor: Colors.blue,
        ),
      ),
    );
  }
}
