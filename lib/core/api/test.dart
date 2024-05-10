import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:papyrus/firebase_options.dart';

class BookClub {
  final String name;
  final String description;

  BookClub({required this.name, required this.description});

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'description': description,
    };
  }
}

Future<DocumentSnapshot> getUserByUsername(String username) async {
  try {
    CollectionReference usersRef =
        FirebaseFirestore.instance.collection('Users');
    QuerySnapshot querySnapshot =
        await usersRef.where('username', isEqualTo: username).get();

    if (querySnapshot.docs.isNotEmpty) {
      return querySnapshot.docs.first;
    } else {
      throw Exception('No user found with username $username');
    }
  } catch (e) {
    print('Error getting user by username: $e');
    rethrow;
  }
}

Future<void> inviteUser(
    {required String username, required BookClub bookClub}) async {
  try {
    CollectionReference usersRef =
        FirebaseFirestore.instance.collection('Users');

    // Get the user document using the provided username
    DocumentSnapshot userSnapshot = await getUserByUsername(username);
    final userData = userSnapshot.data() as Map<String, dynamic>;

    // Get the user's email from the user document
    final userEmail = userData['email'];

    // Add the book club invitation to the user's invites collection
    await usersRef.doc(userEmail).collection('invites').add(bookClub.toMap());

    print('Invitation sent to $username');
  } catch (e) {
    print('Error inviting user: $e');
  }
}

// Test the inviteUser function
Future<void> testInviteUser() async {
  try {
    String username =
        'Babywalrus'; // Replace with the username you want to invite
    BookClub bookClub =
        BookClub(name: 'Reading Group', description: 'A club for book lovers');

    // Invite the user to the book club
    await inviteUser(username: username, bookClub: bookClub);

    print('Invitation sent successfully!');
  } catch (e) {
    print('Failed to send invitation: $e');
  }
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  testInviteUser();
}
