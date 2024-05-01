import 'package:flutter/material.dart';
import 'package:papyrus/bottom_nav_bar_copy.dart';
import 'package:papyrus/screens/book_club_screen/book_club_screen.dart';
import 'package:papyrus/screens/my_book_clubs/my_book_clubs.dart';
import 'package:papyrus/screens/widgets/information_box.dart';

void main() {

  runApp(
    MaterialApp(
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xFF001A23),
      ),
      initialRoute: '/', 
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