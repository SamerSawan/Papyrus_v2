import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:papyrus/core/api/firestore_service.dart';
import 'package:papyrus/core/models/book_club.dart';
import 'package:papyrus/core/models/invite.dart';

class NotificationItem extends StatelessWidget {
  final Invite invite;
  final Function onDelete;
  NotificationItem({super.key, required this.invite, required this.onDelete});

  FirestoreService firestoreService = FirestoreService();
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
    final userDocRef =
        FirebaseFirestore.instance.collection("Users").doc(currentUser?.email);

    // Fetch user's book club IDs
    userDocRef.get().then((DocumentSnapshot userDoc) {
      final userData = userDoc.data() as Map<String, dynamic>;
      List<String> bookClubIds =
          List<String>.from(userData['bookClubIds'] ?? []);

      // Add the new book club ID
      bookClubIds.add(invite.bookClubID);

      // Update user document with the new book club IDs
      userDocRef.update({'bookClubIds': bookClubIds}).then((_) {
        // Delete the invite after the update
        userDocRef.collection("invites").doc(invite.inviteID).delete();
        onDelete();
      }).catchError((error) {
        print("Error updating user document: $error");
      });
    }).catchError((error) {
      print("Error getting user document: $error");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          FutureBuilder<BookClub?>(
            future: firestoreService.fetchBookClubById(invite.bookClubID),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return CircularProgressIndicator(); // Show a loading indicator while fetching data
              } else if (snapshot.hasError ||
                  !snapshot.hasData ||
                  snapshot.data == null) {
                return Text(
                    'Error fetching book club'); // Handle errors or no data
              } else {
                // Render the book club details
                final bookClub = snapshot.data!;
                return Column(
                  children: [
                    Text(
                      bookClub.name,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(bookClub.description),
                    const SizedBox(height: 8),
                  ],
                );
              }
            },
          ),
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
