import 'package:firebase_auth/firebase_auth.dart';
import "package:flutter/material.dart";

import 'package:flutter/material.dart';
import 'package:papyrus/auth/login_or_signup.dart';
import 'package:papyrus/real_nav_bar.dart';
import 'package:papyrus/screens/my_book_clubs/my_book_clubs.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: StreamBuilder(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return const BottomNavBarCopy();
        } else {
          return const LoginOrSignup();
        }
      },
    ));
  }
}
