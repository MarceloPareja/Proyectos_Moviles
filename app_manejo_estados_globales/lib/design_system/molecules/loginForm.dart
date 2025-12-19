import 'package:app_manejo_estados_globales/design_system/atoms/actionButton.dart';
import 'package:app_manejo_estados_globales/design_system/atoms/passwordInput.dart';
import 'package:app_manejo_estados_globales/design_system/atoms/textInput.dart';
import 'package:app_manejo_estados_globales/design_system/atoms/warningMessage.dart';
import 'package:app_manejo_estados_globales/design_system/pages/userHomePage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../global_state/loginData.dart';

/*Este widget es el formulario de login.
Contienen dos campos de texto para usuario y contraseña
y un botón para enviar.
Está designado para validar que los campos no estén vacíos,
y comprueba con el estado global que el usuario y contraseña
sean validos.
*/

class loginForm extends StatefulWidget {
  const loginForm({super.key});

  @override
  State<loginForm> createState() => _loginFormState();
}

class _loginFormState extends State<loginForm> {
  bool _missing_fields=false;//Es verdadero si uno de los campos está vacío
  String user="";//Input de usuario
  String password="";//Input de contraseña
  String errorMsg="";//Mensaje de error a mostrar


  /*Comprueba que no hayan campos vacíos y que los datos
  ingresados sean válidos
   */
  bool login_validate()
  {
    bool? authentication=Provider.of<loginData>(context, listen: false).validateUser(user, password);
    return(!_missing_fields && authentication!);
  }

  /*Comprueba las condiciones para enviar, y si se cumplen
  cambia de pantalla y muestra una notificación de confirmación
   */
  void login()
  {
    if(login_validate())
      {
        //Notificación de confirmación
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
                backgroundColor: Colors.blue,
                duration: Duration(seconds: 2),
                content:  Text(
                    "Sesión iniciada con éxito",
                    style: TextStyle(
                        color: Colors.white
                    )
                )
            ));
        //Actualiza los datos del estado global
        Provider.of<loginData>(context, listen: false).acceptData(user, password);
        //Cambia a la pantalla de inicio
        Navigator.push(context, MaterialPageRoute(builder: (context)=> userHomePage()));
      }
    else
      {
        errorMsg="Usuario o contraseña incorrectos";
      }
  }

  /*Esta funcion toma el valor del input usuario y valida
  que no esté vacío*/
  void getUser(String input)
  {
    setState(() {
      user=input;
    });
    validate_missing_fields();
  }

  /*Esta funcion toma el valor del input contraseña y valida
  que no esté vacío*/
  void getPassword(String input)
  {
    setState(() {
      password=input;
    });
    validate_missing_fields();
  }


  /*Esta funcion valida que ambos campos tengan texto*/
  void validate_missing_fields()
  {
      if(user.isEmpty || password.isEmpty)
        {
          _missing_fields=true;
          errorMsg="Error, no puede dejar los campos vacíos";
        }
      else
        {
          _missing_fields=false;
        }
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [BoxShadow(
          color: Colors.grey,
            offset: new Offset(2.0,2.0),
          blurRadius: 1,
          spreadRadius: 1.5
        )],
      ),
      padding: EdgeInsets.all(8),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text("Iniciar Sesión",//Título del formulario
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold
            ),
          ),
          textInput(label: "Usuario", action: getUser,),//Ingreso de usuario
          passwordInput(action: getPassword,),//Ingreso de contraseña
          SizedBox(height: 10,),
          //Mensaje en caso de error
          warningMessage(visible: _missing_fields, message: errorMsg),
          //Botón de ingreso
          ActionButton(label: "Ingresar", icon: Icons.login_outlined, action: login)
        ],
      ),
    );
  }
}
