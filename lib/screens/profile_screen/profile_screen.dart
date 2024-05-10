import "package:cloud_firestore/cloud_firestore.dart";
import "package:firebase_auth/firebase_auth.dart" as auth;
import "package:flutter/cupertino.dart";
import "package:flutter/material.dart";
import "package:papyrus/core/models/user.dart";
import "package:papyrus/screens/notifications_screen/notifications_screen.dart";

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
          backgroundColor: const Color(0xFF001A23),
          middle: const Text(
            "Profile",
            style: TextStyle(
              color: Color(0xFFF5F5DD),
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          trailing: IconButton(
            icon: const Icon(Icons.notifications),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => NotificationsScreen()),
              );
            },
          ),
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
              return Center(
                child: Column(
                  children: [Text(user.email), Text(user.username)],
                ),
              );
            } else {
              return Text("No data");
            }
          },
        ));
  }
}
