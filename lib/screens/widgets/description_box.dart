import 'package:flutter/material.dart';
import 'package:papyrus/core/models/book.dart';
import 'package:papyrus/core/models/book_club.dart';

class DescriptionBox extends StatelessWidget {
  final String description;
  const DescriptionBox({super.key, required this.description});

  @override
  Widget build(context) {
    return 
            Container(
                margin: const EdgeInsets.only(left: 0, right: 3.5),
                width: 180,
                height: 90,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6),
                    color: const Color(0x8053917E)),
                child: Center(
                  child: Text(description,
                      style: const TextStyle(
                        color: Color.fromARGB(255, 245, 245, 221),
                        fontFamily: 'Inter',
                        fontSize: 12,
                      ))
                )
    );
  }
}
