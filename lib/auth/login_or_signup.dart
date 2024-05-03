import 'package:flutter/material.dart';
import 'package:papyrus/screens/login_screen/login_screen.dart';
import 'package:papyrus/screens/signup_screen/signup_screen.dart';

class LoginOrSignup extends StatefulWidget {
  const LoginOrSignup({super.key});

  @override
  State<LoginOrSignup> createState() => _LoginOrSignupState();
}

class _LoginOrSignupState extends State<LoginOrSignup> {
  bool showLoginPage = true;

  void togglePages() {
    setState(() {
      showLoginPage = !showLoginPage;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (showLoginPage) {
      return LoginScreen(onTap: togglePages);
    } else {
      return SignUpScreen(onTap: togglePages);
    }
  }
}
