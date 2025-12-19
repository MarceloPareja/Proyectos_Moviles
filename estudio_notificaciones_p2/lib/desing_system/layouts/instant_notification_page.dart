import 'package:estudio_notificaciones_p2/desing_system/layouts/notification_detail_page.dart';
import 'package:estudio_notificaciones_p2/services/notifications/local_notification_service.dart';
import 'package:flutter/material.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
class InstantNotificationPage extends StatefulWidget {
  const InstantNotificationPage({super.key});

  @override
  State<InstantNotificationPage> createState() => _InstantNotificationPageState();
}

class _InstantNotificationPageState extends State<InstantNotificationPage> {
  //Notificaciones en primer plano
  void firebaseMessaging() async{
    //Obtener instancia
    FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;
    //Pedir permisos para recibir la notificaciòn en 2do y terminate
    NotificationSettings settings = await firebaseMessaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    print('User granted permission: ${settings.authorizationStatus}');
    //Solicitar permiso
    String? token= await firebaseMessaging.getToken();
    print("FCM Token=${token}");

  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    String title=message.notification?.title ?? "N/A";
    String body=message.notification?.body ?? "N/A";
    print("Notificacion Recibida");

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: Text(body, maxLines: 1, style: TextStyle(overflow: TextOverflow.ellipsis),),
        actions: [
          TextButton(onPressed: (){
            Navigator.pop(context);
          }, child: Text("Aceptar")),
          TextButton(onPressed: (){
            Navigator.pop(context);
          }, child: Text("Cancelar")),
        ],
    )
    );
  });

  //Segundo plano de notificaciones
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      String title=message.notification?.title ?? "N/A";
      String body=message.notification?.body ?? "N/A";
      Navigator.push(context, MaterialPageRoute(builder:
          (context)=>
              NotificationDetailPage(title: title, content: body)));
    });

    //Tercer Plano
    firebaseMessaging.getInitialMessage().then(
        (message){
          if(message!=null){
            final title=message.notification?.title ?? "N/A";
            final body=message.notification?.body ?? "N/A";
            Navigator.push(context, MaterialPageRoute(builder:
            (context)=>
            NotificationDetailPage(title: title, content: body)));
          }
        }
    );
  }



  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    firebaseMessaging();
  }
  @override
  Widget build(BuildContext context) {
    return 
      Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.primary,
          foregroundColor: Theme.of(context).colorScheme.onPrimary,
          title: Text("Notificaciones"),
          
        ),
        body: Center(
          child: Column(
            spacing: 10,
            children: [
              Text("Contenido. Las notificaciones se reciben de forma remota."),
              ElevatedButton(onPressed: (){
                LocalNotificationService().showNotificationasync(title: "Ni notificacion");
              }, child: Text("Notificacion Instantanea")),
              ElevatedButton(onPressed: (){}, child: Text("Notificacion en segundo plano")),
            ],
          ),
        ),
      );
  }
}
