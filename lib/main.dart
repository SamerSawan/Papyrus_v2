import 'package:flutter/material.dart';
import 'package:papyrus/core/models/book_club.dart';
import 'package:papyrus/screens/read_along_screen/widgets/book_card.dart';
import 'package:papyrus/screens/read_along_screen/widgets/book_timeline.dart';
import 'package:papyrus/reading_progress.dart';
import 'screens/read_along_screen/widgets/description_box.dart';

void main() {
  BookClub bookClub = BookClub(
    name: "shareholder pleasers",
    currentBook: "Anna Karenina",
    description: "Temporary Description",
    users: [],
  );

  runApp(
    MaterialApp(
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xFF001A23),
      ),
      home: Scaffold(
          body: ListView(children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(bookClub.name,
                textAlign: TextAlign.center,
                style: const TextStyle(
                    color: Color.fromRGBO(245, 245, 221, 1),
                    fontFamily: 'Inter',
                    fontSize: 16,
                    fontWeight: FontWeight.bold)),
            const BookCard(),
            DescriptionBox(
              description: bookClub.description,
            ),
            const ReadingProgress(),
            const BookTimeline()
          ],
        ),
      ])),
    ),
  );
}
