import 'package:flutter/material.dart';
import 'package:papyrus/core/models/book_club.dart';
import 'package:papyrus/screens/widgets/book_card.dart';
import 'package:papyrus/screens/widgets/book_club_title.dart';
import 'package:papyrus/screens/widgets/book_timeline.dart';
import 'package:papyrus/reading_progress.dart';
import 'package:papyrus/screens/widgets/information_box.dart';
import 'package:papyrus/screens/widgets/description_box.dart';

  BookClub bookClub = BookClub(
    name: "shareholder pleasers",
    currentBook: "Anna Karenina",
    description: "Temporary Description",
    users: [],
  );

class BookClubScreen extends StatelessWidget {
  const BookClubScreen({super.key});
  
  @override
  Widget build(context) {
    return
      Scaffold(
          body: ListView(children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [BookClubTitle(name: bookClub.name),
            const BookCard(),
            Align(
      alignment: const AlignmentDirectional(0, 0.67),
      child: Container(
        width: 367,
        height: 90,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          children: [DescriptionBox(description: bookClub.description), const InformationBox()
          ],
        ),
      ),
    ),
            const ReadingProgress(),
            const BookTimeline()
          ],
        ),
      ]));
  }
}
  

