import 'package:provider/provider.dart';

import '../../data/services/profesor_service.dart';
import '../../domain/entities/profesor.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../data/remote_repositories/profesor_repository.dart';
import '../providers/profesor_provider.dart';
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginScreen> {
  TextEditingController userControl=TextEditingController();
  TextEditingController passwordControl=TextEditingController();
  final profesorRepository=ProfesorRepository();
  final _service = ProfesorService();
  String username="";

  @override
  void initState() {
    super.initState();
  }

  Future<bool> loginUser()async{
    if(await _service.login(userControl.text, passwordControl.text))
      {
        //Confirma el login y guarda el estado global
        Profesor user=await _service.getByMail(userControl.text);
        Provider.of<ProfesorProvider>(context, listen: false).setUser(user);
        return true;
      }
    else{
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Ingresar"),
        ),
        body:
            Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Iniciar Sesiòn",
                    style: TextStyle(fontWeight: FontWeight.bold),),
                  SizedBox(height: 20),
                  SizedBox(width: 170),
                  SizedBox(
                    width: 250,
                    child: TextField(
                      controller: userControl,
                      decoration: const InputDecoration(labelText: 'Correo electronico',
                    ),
                  )),
                  SizedBox(height: 20),
                  SizedBox(
                    width: 250,
                    child: TextField(
                      controller: passwordControl,
                      decoration: const InputDecoration(labelText: 'Contraseña'),
                      obscureText: true,
                    ),
                  ),
                  SizedBox(height: 10,),
                  ElevatedButton(onPressed: () async {
                    if(await loginUser())
                    {
                      context.go('/courses');
                    }
                    else{
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text("Usuario o contraseña incorrectos"),
                        ));
                    }
                  }, child: Text("Ingresar")),
                  SizedBox(height: 10,),
                  Text('¿No tienes cuenta? '),
                  TextButton(
                    onPressed: () {
                      print("intentando registrarse");
                      context.go('/register');
                    },
                    child: const Text(
                      'Regístrate aquí',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.blue,
                      ),
                    ),
                  )
                ],
              ),
            )
    );
  }
}