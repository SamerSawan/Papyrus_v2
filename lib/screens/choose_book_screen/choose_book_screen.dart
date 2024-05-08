import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:papyrus/core/models/book_club.dart';
import 'package:papyrus/screens/widgets/book_card.dart';
import 'package:papyrus/screens/widgets/book_timeline.dart';
import 'package:papyrus/screens/widgets/reading_progress.dart';
import 'package:papyrus/screens/widgets/information_box.dart';
import 'package:papyrus/screens/widgets/description_box.dart';
import 'package:papyrus/screens/widgets/popup_update_progress.dart';

BookClub bookClub = BookClub(
  name: "shareholder pleasers",
  currentBook: "Anna Karenina",
  description: "Temporary Description",
  users: [],
);

class ChooseBookScreen extends StatefulWidget {
  const ChooseBookScreen({super.key});

  @override
  State<ChooseBookScreen> createState() => _ChooseBookScreenState();
}

class _ChooseBookScreenState extends State<ChooseBookScreen> {
  //final _formKey = GlobalKey<FormState>();

  @override
  Widget build(context) {
    return Scaffold(
      body: ListView(
        children: [
          CupertinoNavigationBar(
            middle: const Text("Choose a book for your club",
                style: TextStyle(
                    color: Color.fromRGBO(245, 245, 221, 1),
                    fontFamily: 'Inter',
                    fontSize: 16,
                    fontWeight: FontWeight.bold)),
            leading: IconButton(
              icon: const Icon(Icons.arrow_back_ios, color: Colors.grey),
              onPressed: () => Navigator.of(context).pop(),
            ),
            backgroundColor: const Color(0xFF001A23),
          ),
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
        ],
      ),
    );
  }
}
