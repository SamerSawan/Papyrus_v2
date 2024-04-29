import 'package:flutter/material.dart';

class BookClubTitle extends StatelessWidget {
    final String name;
    const BookClubTitle({super.key, required this.name});

@override
  Widget build(context) {
    return 
            Center(
                  child: Text(name,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                    color: Color.fromRGBO(245, 245, 221, 1),
                    fontFamily: 'Inter',
                    fontSize: 16,
                    fontWeight: FontWeight.bold)),
    );
    }
}