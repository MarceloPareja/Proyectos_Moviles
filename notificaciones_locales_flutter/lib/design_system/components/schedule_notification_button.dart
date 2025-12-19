import 'package:flutter/material.dart';
import '../../services/notification_service.dart';
class ScheduleNotificationButton extends StatelessWidget {
  final VoidCallback action;
  const ScheduleNotificationButton({super.key,
  required this.action});

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
          NotificationService().scheduleNotification();
        },
        child: Text("Generar Notificación"));
  }
}
