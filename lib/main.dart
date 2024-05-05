import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:papyrus/firebase_options.dart';
import 'package:papyrus/real_nav_bar.dart';
import 'package:papyrus/screens/book_club_screen/book_club_screen.dart';
import 'package:papyrus/screens/widgets/information_box.dart';
import 'package:papyrus/screens/my_book_clubs/my_book_clubs.dart';

void main() async {
WidgetsFlutterBinding.ensureInitialized();
await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(
    MaterialApp(
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xFF001A23),
      ), 
      initialRoute: '/', 
      routes: {'/': (context) => const MyBookClubs(),
              '/InfoBox': (context) => const InformationBox(),
              '/BookClubScreen': (context) => const BookClubScreen(),
               },
        builder: (context, child) {
        return const BottomNavBarCopy();
      }
    ),
  );
}

/* was in builder, but does not seem to be required to keep nav bar on all pages
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
              ]
*/