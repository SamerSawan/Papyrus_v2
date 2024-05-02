import 'package:flutter/material.dart';
import 'package:papyrus/core/models/book_club.dart';
import 'package:papyrus/screens/book_club_screen/book_card.dart';
import 'package:papyrus/screens/book_club_screen/book_timeline.dart';
import 'package:papyrus/screens/book_club_screen/reading_progress.dart';
import 'package:papyrus/screens/book_club_screen/information_box.dart';
import 'package:papyrus/screens/book_club_screen/description_box.dart';
import 'package:papyrus/screens/book_club_screen/update_progress.dart';

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
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: const UpdateBox(),
      body: ListView(children: [
        Positioned(
                  top: 0.0,
                  left: 0.0,
                  right: 0.0,
                  child: AppBar(
                    title: Text(bookClub.name, 
                    style: const TextStyle(
                    color: Color.fromRGBO(245, 245, 221, 1),
                    fontFamily: 'Inter',
                    fontSize: 16,
                    fontWeight: FontWeight.bold)),
                    leading: IconButton(
                      icon: const Icon(Icons.arrow_back_ios, color: Colors.grey),
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                    backgroundColor: Colors.blue.withOpacity(0),
                    elevation: 0.0, //No shadow
                  ),),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
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
