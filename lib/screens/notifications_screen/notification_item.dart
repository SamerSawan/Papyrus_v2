import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:papyrus/core/models/book_club.dart';
import 'package:papyrus/core/models/invite.dart';

class NotificationItem extends StatelessWidget {
  final Invite invite;
  final Function onDelete;
  const NotificationItem(
      {super.key, required this.invite, required this.onDelete});

  void _rejectInvite(
    Invite invite,
  ) {
    User? currentUser = FirebaseAuth.instance.currentUser;
    final docRef =
        FirebaseFirestore.instance.collection("Users").doc(currentUser?.email);
    docRef.collection("invites").doc(invite.inviteID).delete();
  }

  void _acceptInvite(BuildContext context, Invite invite) {
    User? currentUser = FirebaseAuth.instance.currentUser;
    final docRef =
        FirebaseFirestore.instance.collection("Users").doc(currentUser?.email);
    docRef.get().then(
      (DocumentSnapshot doc) {
        final data = doc.data() as Map<String, dynamic>;
        List<BookClub> newBookClubs =
            data['bookClubs'].map<BookClub>((clubMap) {
          return BookClub.fromMap(clubMap);
        }).toList();

        newBookClubs.add(invite.bookClub);
        FirebaseFirestore.instance
            .collection("Users")
            .doc(currentUser?.email)
            .update({
          'bookClubs': newBookClubs.map((club) => club.toMap()).toList(),
        });
        onDelete();
      },
      onError: (e) => print("Error getting document: $e"),
    );

    docRef.collection("invites").doc(invite.inviteID).delete();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Column(children: [
            Text(
              invite.bookClub.name,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            const SizedBox(height: 8),
            Text(invite.bookClub.description),
            const SizedBox(height: 8),
          ]),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: () {
                  // Accept invite action
                  _acceptInvite(context, invite);
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.green),
                ),
                child: const Text('Accept invite'),
              ),
              ElevatedButton(
                onPressed: () {
                  // Reject invite action
                  _rejectInvite(invite);
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.red),
                ),
                child: const Text('Reject invite'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
