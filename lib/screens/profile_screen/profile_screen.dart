import "package:cloud_firestore/cloud_firestore.dart";
import "package:firebase_auth/firebase_auth.dart" as auth;
import "package:flutter/cupertino.dart";
import "package:flutter/material.dart";
import "package:papyrus/core/models/user.dart";

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
              return Column(
                // body goes here
                children: [Text(user.email), Text(user.username)], 
              );
            } else {
              return const Text("No data"); // added const
            }
          },
        ));
  }
}
