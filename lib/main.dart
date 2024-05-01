import 'package:flutter/material.dart';
import 'package:papyrus/real_nav_bar.dart';
import 'package:papyrus/screens/book_club_screen/book_club_screen.dart';
import 'package:papyrus/screens/book_club_screen/information_box.dart';

void main() {

  runApp(
    MaterialApp(
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xFF001A23),
      ), initialRoute: '/', 
      routes: {'/': (context) => const BookClubScreen(),
              '/InfoBox': (context) => const InformationBox(),
              '/BookClubScreen': (context) => const BookClubScreen(),
               },
      builder: (context, child) {
        return Stack(
          children: [
            child!, 
            Overlay(
              initialEntries: [
                OverlayEntry(
                  builder: (context) {
                      return const BottomNavBarCopy();
                      }
                    )
                  ],
                )
              ],
          );
      }
    ),
  );
}