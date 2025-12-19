import 'package:flutter/material.dart';
import 'design_system/components/notification_button.dart';
import 'design_system/layouts/instant_notification_page.dart';
import 'design_system/layouts/scheduled_notification_page.dart';
import 'services/notification_service.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await NotificationService().initialize();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        "/instant": (context) => InstantNotificationPage(),
        "/scheduled": (context) => ScheduledNotificationPage(),
      },
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueAccent)
      ),
        debugShowCheckedModeBanner: false,
      home:  InstantNotificationPage()
    );
  }
}
