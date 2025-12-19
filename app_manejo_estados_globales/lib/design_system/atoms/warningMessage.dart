import 'package:flutter/material.dart';

/*Este widget representa una alerta que solo se vuelve
visible si esta propiedad está como verdadero.
Esto permite pasar una condición, y un texto de advertencia.
Si se cumple la condición se muestra el texto, pero
si no hay error, se oculta.
*/

class warningMessage extends StatelessWidget {
  final bool visible;
  final String message;
  warningMessage({super.key,
    required this.visible,
    required this.message
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: visible ? 50 : 0,
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.red[50]!,
      ),
      child: Center(
        child: Text(
          visible ? message : "",
          style: TextStyle(
            color: Colors.red
          ),
        ),
      ),
    );
  }
}
