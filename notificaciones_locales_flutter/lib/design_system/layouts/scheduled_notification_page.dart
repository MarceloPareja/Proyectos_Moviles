import 'package:flutter/material.dart';
import '../../design_system/components/navigation_bar.dart';
import '../../design_system/components/schedule_notification_button.dart';
import '../../services/notification_service.dart';
import '../../design_system/components/NumberInput.dart';
class ScheduledNotificationPage extends StatefulWidget {
  const ScheduledNotificationPage({super.key});

  @override
  State<ScheduledNotificationPage> createState() => _ScheduledNotificationPageState();
}

class _ScheduledNotificationPageState extends State<ScheduledNotificationPage> {
  int _seconds = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myNavigationBar(),
      body: Container(
        child: Center(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              spacing: 20,
              children: [
                Text("Ingrese los segundos"),
                NumberInput(action: (value){
                  setState(() {
                    _seconds=int.parse(value);
                  });
                }, inputLabel: "Segundos"),
                ScheduleNotificationButton(action: () {
                  NotificationService().scheduleNotification();
                })
              ]
          ),
        ),
      ),
    );
  }
}
