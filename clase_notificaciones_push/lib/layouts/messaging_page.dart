import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

import 'notification_detail_page.dart';
class MessagingPage extends StatefulWidget {
  const MessagingPage({super.key});

  @override
  State<MessagingPage> createState() => _MessagingPageState();
}

class _MessagingPageState extends State<MessagingPage> {
  //1.Agregar la notificaciòn push
  void firebaseMessaging() async{
    print("NOTIFICACIONES");
    FirebaseMessaging messaging = FirebaseMessaging.instance;
    //Colocar el token de FCM, que permite
    String? token = await messaging.getToken();
    print("FCM token: ${token}");

    //1.Notificaciones en primer plano
    FirebaseMessaging.onMessage.listen((RemoteMessage message){
      final title=message.notification?.title ?? "N/A";
      final body=message.notification?.body ?? "N/A";

      showDialog(
        context: context,
        builder: (context)=>AlertDialog(
          title: Text(title),
          content: Text(
            body,
            maxLines: 1,
            style: TextStyle(overflow: TextOverflow.ellipsis),
          ),
          actions:[
            TextButton(
              onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>NotificationDetailPage(title: title, content: body)));
              },
              child: Text("Next"),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text("Close"),
            ),
          ],
        ),
      );
    });

    //2.Notificaciones en segundo plano
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message){
      final title=message.notification?.title ?? "N/A";
      final body=message.notification?.body ?? "N/A";
      Navigator.push(context, MaterialPageRoute(builder: (context)=>NotificationDetailPage(title: title, content: body)));
    });

    //3.Notificaciones con app terminada
    FirebaseMessaging.instance.getInitialMessage().then(
        (message){
          //si es null no hay notificaciòn
          if(message!=null){
            final title=message.notification?.title ?? "N/A";
            final body=message.notification?.body ?? "N/A";
            Navigator.push(context, MaterialPageRoute(builder: (context)=>NotificationDetailPage(title: title, content: body)));
          }

        }
    );
  }


 @override
 void initState()
 {
   super.initState();
   firebaseMessaging();
 }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Notificaciones"),
        ),
      body: Center(
        child: Text("Notificaciones"),
      ),
    );
  }
}
