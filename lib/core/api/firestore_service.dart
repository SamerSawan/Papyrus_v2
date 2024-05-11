import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:papyrus/core/models/book_club.dart';
import 'package:papyrus/core/models/invite.dart';

class FirestoreService {
  final CollectionReference usersRef =
      FirebaseFirestore.instance.collection('Users');
  final CollectionReference comments =
      FirebaseFirestore.instance.collection('comments');
  final CollectionReference percentage =
      FirebaseFirestore.instance.collection('percentage');
  final CollectionReference username =
      FirebaseFirestore.instance.collection('username');

  Future<String?> getCurrentUserUsername() async {
    User? currentUser = FirebaseAuth.instance.currentUser;
    String? email = currentUser!.email;
    try {
      // Retrieve the document snapshot of the user with the provided email
      DocumentSnapshot userSnapshot =
          await FirebaseFirestore.instance.collection("Users").doc(email).get();

      // Check if the document exists
      if (userSnapshot.exists) {
        // Extract the username from the document data
        final data = userSnapshot.data() as Map<String, dynamic>;
        String username = data['username'];
        return username;
      } else {
        // User document doesn't exist
        return null;
      }
    } catch (e) {
      // Error occurred while fetching user data
      print("Error fetching user data: $e");
      return null;
    }
  }

  Future<BookClub?> fetchBookClubById(String id) async {
    try {
      DocumentSnapshot doc = await FirebaseFirestore.instance
          .collection("BookClubs")
          .doc(id)
          .get();
      if (doc.exists) {
        // Convert the document data to a BookClub object
        return BookClub.fromMap(doc.data() as Map<String, dynamic>);
      } else {
        return null;
      }
    } catch (e) {
      print("Error fetching BookClub: $e");
      return null;
    }
  }

  Future<DocumentSnapshot> getUserByUsername(String username) async {
    try {
      // Query the collection where username matches
      QuerySnapshot querySnapshot = await usersRef
          .where('username', isEqualTo: username.toLowerCase())
          .get();

      // Check if any documents were found
      if (querySnapshot.docs.isNotEmpty) {
        // Return the first document found (assuming usernames are unique)
        return querySnapshot.docs.first;
      } else {
        // If no user found with the provided username
        throw Exception('No user found with username $username');
      }
    } catch (e) {
      // Handle errors
      print('Error getting user by username: $e');
      rethrow;
    }
  }

  Future<void> inviteUser({
    required String username,
    required String
        bookClubId, // Accept book club ID instead of BookClub object
  }) async {
    DocumentSnapshot userSnapshot = await getUserByUsername(username);
    final data = userSnapshot.data() as Map<String, dynamic>;
    final userEmail = (data['email'] as String).toLowerCase();

    // Create a map with just the book club ID
    final inviteData = {'bookClubID': bookClubId};

    await usersRef.doc(userEmail).collection('invites').add(inviteData);
  }

  Future<List<Invite>> getInvites() async {
    User? currentUser = FirebaseAuth.instance.currentUser;
    String? email = currentUser!.email;

    // Get invite documents
    final inviteDocs = await FirebaseFirestore.instance
        .collection('Users')
        .doc(email)
        .collection('invites')
        .get();

    print("Invite docs: ${inviteDocs.toString()}");

    // Map invite documents to Invite objects
    return inviteDocs.docs.map((doc) {
      String inviteID = doc.id;
      String bookClubID =
          doc.data()['bookClubID']; // Assuming the field name is 'bookClubID'

      // Create and return Invite object
      return Invite(inviteID: inviteID, bookClubID: bookClubID);
    }).toList();
  }

  Future<void> addComment(String comment, dynamic percentage) async {
    String? currentUsername = await getCurrentUserUsername();
    comments.add({
      'comment': comment,
      'timestamp': Timestamp.now(),
      'percentage': percentage,
      'likes': [],
      'username': currentUsername,
    });
    return;
  }

  Stream<QuerySnapshot> getCommentsStream() {
    final commentsStream =
        comments.orderBy('timestamp', descending: true).snapshots();

    return commentsStream;
  }
}
