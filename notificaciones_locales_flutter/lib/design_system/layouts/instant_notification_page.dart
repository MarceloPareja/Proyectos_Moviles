import 'package:flutter/material.dart';
import '../../design_system/components/navigation_bar.dart';

import '../components/notification_button.dart';
class InstantNotificationPage extends StatelessWidget {
  const InstantNotificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myNavigationBar(),
      body: Container(
        child: Center(
          child: NotificationButton(),
        ),
      ),
    );
  }
}
