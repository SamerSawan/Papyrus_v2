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

  void displayAddBookClub() {}

  void logout() {
    FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(context) {
    return Scaffold(
      body: ListView(children: [
        CupertinoNavigationBar(
          middle: Text('My Book Clubs',
              style: Theme.of(context).textTheme.titleMedium,
              ),
          backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
          leading:
              IconButton(onPressed: logout, icon: const Icon(Icons.logout)),
          trailing: IconButton(
              onPressed: displayAddBookClub, icon: const Icon(Icons.add)),
        ), // need to find a good place for this
        Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(width: 367, child: SearchTextField()),
              CupertinoButton(
                child: const BookClubCard(),
                onPressed: () {
                  Navigator.of(context).push(CupertinoPageRoute(
                      builder: (context) => const BookClubScreen()
                      ));
                },
              ),
            ])
      ]),
    );
  }
}
