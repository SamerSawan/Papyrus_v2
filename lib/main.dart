import 'package:flutter/material.dart';
import 'package:papyrus/book_timeline.dart';
import 'package:papyrus/reading_progress.dart';
import 'description_box.dart';

void main() {
  runApp(MaterialApp(
    theme: ThemeData(
      scaffoldBackgroundColor: const Color(0xFF001A23),
    ),
    home: const Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [BookCard(),
          DescriptionBox(), ReadingProgress(), BookTimeline()
        ],
      ),
    ),
  ));
}

class BookCard extends StatelessWidget {
  const BookCard({super.key});

  @override
  Widget build(context) {
    return Center(
      child: Column(
        children: [
          Container(
              margin: const EdgeInsets.all(10.0),
              width: 367.0,
              height: 150.0,
              decoration: BoxDecoration(
   borderRadius: BorderRadius.circular(6),
   color: const Color(0xFF53917E).withOpacity(0.5),
              )
              ),
        ],
      ),
    );
  }
}