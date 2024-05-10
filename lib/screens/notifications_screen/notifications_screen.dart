import 'package:flutter/material.dart';

class NotificationsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Invitations'),
      ),
      body: Center(
        child: Text(
            'Display Invitations here'), // You can customize this part to display invitations
      ),
    );
  }
}
