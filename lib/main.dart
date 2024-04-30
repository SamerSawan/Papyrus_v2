import 'package:flutter/material.dart';
import 'package:papyrus/core/models/book_club.dart';
import 'package:papyrus/screens/book_club_screen/book_card.dart';
import 'package:papyrus/screens/book_club_screen/book_club_screen.dart';
import 'package:papyrus/screens/book_club_screen/reading_progress.dart';
import 'package:papyrus/screens/my_book_clubs/my_book_clubs.dart';
import 'package:papyrus/screens/widgets/book_timeline.dart';
import 'screens/widgets/description_box.dart';

void main() {

  runApp(
    MaterialApp(
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xFF001A23),
      ),
      home: const MyBookClubs()
    ),
  );
}
