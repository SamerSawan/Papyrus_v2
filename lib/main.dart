import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:papyrus/core/auth/auth.dart';
import 'package:papyrus/firebase_options.dart';
import 'package:papyrus/theme/dark_mode.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(
    MaterialApp(
      darkTheme: darkMode,
      debugShowCheckedModeBanner: false,
      home: const Scaffold(body: AuthScreen()),
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