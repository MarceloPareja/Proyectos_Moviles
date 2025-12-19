import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest_all.dart' as tz;
class NotificationService {

  final FlutterLocalNotificationsPlugin _notificationsPlugin= FlutterLocalNotificationsPlugin();
  static const androidNotificationDetails = AndroidNotificationDetails(
      "mi_notif_app",
      "Notificaciones locales",
      channelDescription: "Notificaciones locales de flutter",
      importance: Importance.max,
      priority: Priority.high
  );
  /*Función de inicialización. Se ejecuta al iniciar la aplicación y configura los
  permisos necesarios para usar notificaciones
   */
  Future<void> initialize() async{
    tz.initializeTimeZones();
    tz.setLocalLocation(tz.getLocation('America/Guayaquil'));
    //Crea una instancia de configuraciòn para android
    const AndroidInitializationSettings androidSettings = AndroidInitializationSettings('@mipmap/ic_launcher');
    const initializationSettings = InitializationSettings(android: androidSettings);
    await _notificationsPlugin.initialize(initializationSettings);
    await _notificationsPlugin
        .resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>()
        ?.requestNotificationsPermission();
    await _notificationsPlugin.resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>()?.requestExactAlarmsPermission();
  }

  Future<void> showNotification({
    //Datos de la notificaciòn
    int notification_id = 0,
    String notification_title= "Mi notificacion",
    String notification_body = "Contenido",
    String notification_payload= "Hola Mundo",
}) async{
    const NotificationDetails notificationDetails =
    NotificationDetails(android: androidNotificationDetails);

    await _notificationsPlugin.show(
        notification_id,
        notification_title,
        notification_body,
        notificationDetails,
        payload: notification_payload
    );
  }


  Future<void> scheduleNotification({
    int id = 0,
    String title= "Notificacion ",
    String body = "Estoy en segundo plano",
    int secs = 15,
}) async{
    const NotificationDetails notificationDetails =
    NotificationDetails(android: androidNotificationDetails);
    /*Programar la notificacion para un tiempo determinado (Por defecto son 15 segundos)*/
    tz.TZDateTime scheduledTime= tz.TZDateTime.now(tz.local).add(const Duration(seconds: 15));

    await _notificationsPlugin.zonedSchedule(
        id,
        title,
        body,
        scheduledTime,
        notificationDetails,
        androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
    );
  }

}