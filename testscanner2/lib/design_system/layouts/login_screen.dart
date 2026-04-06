import 'package:app_escaneo_pruebas/data/services/profesor_service.dart';
import 'package:app_escaneo_pruebas/domain/entities/profesor.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../data/remote_repositories/profesor_repository.dart';
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
  bool loading=true;
  String username="";

  @override
  void initState() {
    super.initState();
  }

  Future<bool> loginUser()async{
    if(await _service.login(userControl.text, passwordControl.text))
      {
        print("Exito");
      }
    return _service.login(username, passwordControl.text);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Ingresar"),
        ),
        body: (loading) ? (Center(child: CircularProgressIndicator())) : (
            Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text("Iniciar Sesiòn",
                    style: TextStyle(fontWeight: FontWeight.bold),),
                  SizedBox(height: 20),
                  SizedBox(width: 170),
                  SizedBox(
                    width: 300,
                    child: TextField(
                      controller: userControl,
                      decoration: const InputDecoration(labelText: 'Correo electronico'),
                    ),
                  ),
                  SizedBox(height: 20),
                  SizedBox(
                    width: 300,
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
                  }, child: Text("Ingresar"))
                ],
              ),
            )
)
    );
  }
}