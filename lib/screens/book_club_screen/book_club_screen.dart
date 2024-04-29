import 'package:flutter/material.dart';
import 'package:papyrus/bottom_nav_bar.dart';
import 'package:papyrus/core/models/book_club.dart';
import 'package:papyrus/screens/book_club_screen/book_card.dart';
import 'package:papyrus/screens/widgets/book_club_title.dart';
import 'package:papyrus/screens/widgets/book_timeline.dart';
import 'package:papyrus/screens/book_club_screen/reading_progress.dart';
import 'package:papyrus/screens/widgets/information_box.dart';
import 'package:papyrus/screens/widgets/description_box.dart';
import 'package:papyrus/nav_bar.dart';

BookClub bookClub = BookClub(
  name: "shareholder pleasers",
  currentBook: "Anna Karenina",
  description: "Temporary Description",
  users: [],
);

class BookClubScreen extends StatefulWidget {
  const BookClubScreen({super.key});

  @override
  State<BookClubScreen> createState() => _BookClubScreenState();
}

class _BookClubScreenState extends State<BookClubScreen> {
  @override
  Widget build(context) {
    return Scaffold(
      body: ListView(children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            BookClubTitle(name: bookClub.name),
            const BookCard(),
            Align(
                child: SizedBox(
              width: 367,
              height: 90,
              child: Row(children: [
                DescriptionBox(description: bookClub.description),
                const InformationBox()
              ]),
            )),
            const ReadingProgress(),
            const BookTimeline(),
          ],
        ),
      ]),
    );
  }
}
