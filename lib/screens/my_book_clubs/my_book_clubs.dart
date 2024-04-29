import 'package:flutter/material.dart';
import 'package:papyrus/core/models/book_club.dart';
import 'package:papyrus/screens/my_book_clubs/book_club_card.dart';
import 'package:papyrus/screens/book_club_screen/book_club_screen.dart';

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
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                  )),
              const SizedBox(height: 30),
              TextButton(
                child: const BookClubCard(),
                onPressed: () {
                  print("Book Club Card Pressed");
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const BookClubScreen()));
                },
              ),
            ])
      ]),
    );
  }
}
