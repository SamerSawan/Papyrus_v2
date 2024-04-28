import 'package:flutter/material.dart';
import 'package:papyrus/core/models/book_club.dart';
import 'package:papyrus/screens/my_book_clubs/book_club_card.dart';
import 'package:papyrus/core/models/book.dart';
// import 'package:papyrus/screens/widgets/book_club_title.dart';

BookClub bookClub = BookClub(
    name: "shareholder pleasers",
    currentBook: "Anna Karenina",
    description: "Temporary Description",
    users: [],
  );

class MyBookClubs extends StatelessWidget {
  const MyBookClubs ({super.key});

@override
  Widget build(context) {
  return Scaffold(
    body: ListView(children: const [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text('My Book Clubs',
                style: TextStyle(
                color: Color(0xFFF5F5DD),
                fontFamily: 'Inter',
                fontSize: 15,
                fontWeight: FontWeight.w600,
              )
              ), 
              SizedBox(
                  height:30
                ),
              BookClubCard()
              ])]),
);
  }
  }