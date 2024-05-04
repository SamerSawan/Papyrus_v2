import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:papyrus/core/models/book_club.dart';
import 'package:papyrus/screens/book_club_screen/book_club_screen.dart';
import 'package:papyrus/screens/widgets/book_club_card.dart';
import 'package:papyrus/screens/widgets/search_bar_clubs.dart';

BookClub bookClub = BookClub(
  name: "shareholder pleasers",
  currentBook: "Anna Karenina",
  description: "Temporary Description",
  users: [],
);

class MyBookClubs extends StatelessWidget {
  const MyBookClubs({super.key});

  void logout() {
    FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(context) {
    return Scaffold(
      body: ListView(children: [
        CupertinoNavigationBar(
          middle: const Text('My Book Clubs',
              style: TextStyle(
                color: Color(0xFFF5F5DD),
                fontSize: 16,
                fontWeight: FontWeight.w600,
              )),
          backgroundColor: Color(0xFF001A23),
          trailing:
              IconButton(onPressed: logout, icon: const Icon(Icons.logout)),
        ),
        Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(width: 367, child: SearchTextField()),
              CupertinoButton(
                child: const BookClubCard(),
                onPressed: () {
                  Navigator.push(
                      context,
                      CupertinoPageRoute(
                          builder: (context) => const BookClubScreen()));
                },
              ),
            ])
      ]),
    );
  }
}
