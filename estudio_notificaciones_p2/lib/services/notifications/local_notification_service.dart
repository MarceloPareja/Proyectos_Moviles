import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class LocalNotificationService {
  final FlutterLocalNotificationsPlugin _notificationsPlugin=FlutterLocalNotificationsPlugin();
  Future<void> initNotifications()async{
    AndroidInitializationSettings androidSettings=AndroidInitializationSettings('@mipmap/ic_launcher');
    InitializationSettings _initSettings=InitializationSettings(android: androidSettings);
    _notificationsPlugin.initialize(_initSettings);
    //Pide los permisos: Para las notificaciones y para programarlas
    await _notificationsPlugin.resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>()?.requestNotificationsPermission();
    await _notificationsPlugin.resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>()?.requestExactAlarmsPermission();
  }

  Future<void> showNotificationasync({
    int id=0,
    String title="Titulo",
    String body="Cuerpo"
})async {
    NotificationDetails notifDetails=NotificationDetails(
      android: AndroidNotificationDetails("Notificaciones Locales", "Mi propio canal",
      importance: Importance.max,
      priority: Priority.high,)
    );
    await _notificationsPlugin.show(id, title, body, notifDetails);
  }
}