import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:papyrus/core/models/book_club.dart';
import 'package:papyrus/screens/comment_screen/comment_screen.dart';
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

class BookClubScreen extends StatefulWidget {
  const BookClubScreen({super.key});

  @override
  State<BookClubScreen> createState() => _BookClubScreenState();
}

class _BookClubScreenState extends State<BookClubScreen> {
  //final _formKey = GlobalKey<FormState>();

  @override
  Widget build(context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: const PopUpUpdate(),
      body: ListView(children: [
        CupertinoNavigationBar(
          middle: Text(bookClub.name,
              style: Theme.of(context).textTheme.titleMedium,),
          trailing: IconButton(
            icon: const Icon(Icons.chat_bubble_outline_rounded),
            onPressed: () => Navigator.of(context).push(CupertinoPageRoute(builder: (context) => const CommentScreen())),
          ),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios),
            onPressed: () => Navigator.of(context).pop(),
          ),
          backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
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
      ]),
    );
  }
}
