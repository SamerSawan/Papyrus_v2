import 'package:flutter/material.dart';
import 'package:papyrus/book_card.dart';
import 'package:papyrus/book_timeline.dart';
import 'package:papyrus/reading_progress.dart';
import 'description_box.dart';
import 'book_timeline.dart';

void main() {
  runApp(
    MaterialApp(
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xFF001A23),
      ),
      home: Scaffold(
          body: ListView(children: const [
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            BookCard(),
            DescriptionBox(),
            ReadingProgress(),
            BookTimeline()
          ],
        ),
      ])),
    ),
  );
}
