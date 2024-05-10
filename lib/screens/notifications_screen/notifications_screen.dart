import 'package:flutter/material.dart';
import 'package:papyrus/core/api/firestore_service.dart';
import 'package:papyrus/core/models/book_club.dart';
import 'package:papyrus/core/models/invite.dart';
import 'package:papyrus/screens/notifications_screen/notification_item.dart';

class NotificationsScreen extends StatefulWidget {
  NotificationsScreen({Key? key}) : super(key: key);

  @override
  _NotificationsScreenState createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  final FirestoreService firestoreService = FirestoreService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Invitations'),
      ),
      body: FutureBuilder<List<Invite>>(
        future: firestoreService.getInvites(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          } else if (snapshot.hasData) {
            List<Invite> invitations = snapshot.data!;
            if (invitations.isEmpty) {
              return const Center(
                child: Text('No invitations'),
              );
            } else {
              return ListView.builder(
                itemCount: invitations.length,
                itemBuilder: (context, index) {
                  return NotificationItem(
                    invite: invitations[index],
                    onDelete: () {
                      // Call setState to rebuild widget tree when invite is deleted
                      setState(() {
                        // Remove the invite from the list
                        invitations.removeAt(index);
                      });
                    },
                  );
                },
              );
            }
          } else {
            return const Center(
              child: Text('No data'),
            );
          }
        },
      ),
    );
  }
}
