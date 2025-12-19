import 'package:flutter/material.dart';
class NotificationDetailPage extends StatelessWidget {
  final String title;
  final String content;
  const NotificationDetailPage({super.key, required
  this.title, required this.content});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        
      ),
      body: 
      Center(
        child: Text(content),
      ),
    );
  }
}
