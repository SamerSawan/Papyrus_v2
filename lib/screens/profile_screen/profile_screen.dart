import "package:cloud_firestore/cloud_firestore.dart";
import "package:firebase_auth/firebase_auth.dart" as auth;
import "package:firebase_core/firebase_core.dart";
import "package:flutter/cupertino.dart";
import "package:flutter/material.dart";
import "package:papyrus/core/models/user.dart";
import "package:papyrus/firebase_options.dart";
import "package:papyrus/screens/profile_screen/profile_widget.dart";

import "../../theme/dark_mode.dart";

class ProfileScreen extends StatelessWidget {
  ProfileScreen({super.key});

  final auth.User? currentUser = auth.FirebaseAuth.instance.currentUser;

  Future<DocumentSnapshot<Map<String, dynamic>>> getUserDetails() async {
    return await FirebaseFirestore.instance
        .collection("Users")
        .doc(currentUser!.email)
        .get();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CupertinoNavigationBar(
          middle: 
          Text( "Profile",
            style: Theme.of(context).textTheme.titleMedium, // added style
            ),
          backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        ),
        body: FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
          future: getUserDetails(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.hasError) {
              return Text("Error: ${snapshot.error}");
            } else if (snapshot.hasData) {
              User user = User.fromMap(snapshot.data!.data()!);
              return ProfileWidget(
                username: user.username,
              );
            } else {
              return const Text("No data"); // added const
            }
          },
        ));
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(
    MaterialApp(
      darkTheme: darkMode,
      home: ProfileScreen(),
    ),
  );
}