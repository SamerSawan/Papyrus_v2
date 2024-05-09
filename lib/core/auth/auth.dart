import 'package:firebase_auth/firebase_auth.dart';
import "package:flutter/material.dart";
import 'package:papyrus/core/auth/login_or_signup.dart';
import 'package:papyrus/bottom_nav_bar.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: StreamBuilder(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return const BottomNavBar();
        } else {
          return const LoginOrSignup();
        }
      },
    ));
  }
}
