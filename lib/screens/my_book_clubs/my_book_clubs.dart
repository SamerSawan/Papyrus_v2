import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:papyrus/core/models/book_club.dart';
import 'package:papyrus/screens/book_club_screen/book_club_screen.dart';
import 'package:papyrus/screens/my_book_clubs/book_club_card.dart';
import 'package:papyrus/screens/my_book_clubs/search_bar_clubs.dart';

BookClub bookClub = BookClub(
  name: "shareholder pleasers",
  currentBook: "Anna Karenina",
  description: "Temporary Description",
  users: [],
);

class MyBookClubs extends StatelessWidget {
  const MyBookClubs({super.key});

  @override
  Widget build(context) {
    return Scaffold(
      body: ListView(children: [
        Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text('My Book Clubs',
                  style: TextStyle(
                    color: Color(0xFFF5F5DD),
                    fontFamily: 'Inter',
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  )),
                  const SizedBox(height:10),
               const SizedBox(
                width: 367,
                child: SearchTextField()),
              CupertinoButton(
                child: const BookClubCard(),
                onPressed: () {
                  Navigator.push(context, CupertinoPageRoute(
                          builder: (context) => const BookClubScreen()
                      ));
                },
              ),
            ])
      ]),
    );
  }
}
