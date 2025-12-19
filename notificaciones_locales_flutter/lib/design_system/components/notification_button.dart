import 'package:flutter/material.dart';
import '../../services/notification_service.dart';
class NotificationButton extends StatelessWidget {
  const NotificationButton({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ButtonStyle(
          backgroundColor: WidgetStateProperty.fromMap({
            WidgetState.pressed: Theme.of(context).colorScheme.primary.withOpacity(0.5),
            WidgetState.hovered: Theme.of(context).colorScheme.primary.withOpacity(0.1),
          }),
        ),
        onPressed: (){
          NotificationService().showNotification();
        },
        child: Text("Mostrar Notificación"));
  }
}
