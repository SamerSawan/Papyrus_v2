import 'package:flutter/material.dart';
import 'package:papyrus/reading_progress.dart';
import 'package:papyrus/widgets/description_box.dart';

void main() {
  runApp(MaterialApp(
    theme: ThemeData(
      scaffoldBackgroundColor: const Color(0xFF001A23),
    ),
    home: Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
                width: 100.0,
                height: 100.0,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6),
                  color: const Color(0xFF53917E).withOpacity(0.5),
                ),
                child: const Center(
                    child: Text("Logo",
                        style: TextStyle(color: Color(0xFFF5F5DD))))),
          ],
        ),
      ),
    ),
  ));
}