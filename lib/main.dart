import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    theme: ThemeData(
      scaffoldBackgroundColor: const Color(0xFF001A23),
    ),
    home: const Scaffold(
      body: BookCard(),
    ),
  ));
}

class BookCard extends StatelessWidget {
  const BookCard({super.key});

  @override
  Widget build(context) {
    return Center(
      child: Container(
          margin: const EdgeInsets.all(10.0),
          color: const Color(0xFF53917E).withOpacity(0.5),
          width: 350.0,
          height: 150.0),
    );
  }
}
