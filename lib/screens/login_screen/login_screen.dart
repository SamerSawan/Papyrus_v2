import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:papyrus/firebase_options.dart';
import 'package:papyrus/screens/widgets/custom_button.dart';
import 'package:papyrus/screens/widgets/custom_text_input.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  LoginScreenState createState() => LoginScreenState();
}

class LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();

  // text controllers
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  void login() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                child: Text(
                  "Logo",
                  style: TextStyle(
                    color: Color(0xFFF5F5DD),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  CustomTextInput(
                    label: "Username",
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter some text';
                      }
                      // You can add more validation logic here
                      return null; // Return null if the input is valid
                    },
                  ),
                  const SizedBox(height: 20),
                  CustomTextInput(
                    label: "Password",
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter some text';
                      }
                      // You can add more validation logic here
                      return null; // Return null if the input is valid
                    },
                  ),
                  const SizedBox(height: 12),
                ],
              ),
            ),
            Text(
              // needs to be turned into a navigation button
              "Forgot password?",
              style: TextStyle(
                color: const Color(0xFFF5F5DD).withOpacity(0.5),
                fontFamily: 'Inter',
                fontSize: 13,
                fontWeight: FontWeight.w200,
              ),
            ),
            const SizedBox(height: 10),
            CustomButton(
              text: "Sign In",
              onTap: login,
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Don't have an account? ",
                  style: TextStyle(
                    color: Color(0xFFF5F5DD),
                    fontFamily: 'Inter',
                    fontSize: 14,
                    fontWeight: FontWeight.w200,
                  ),
                ),
                GestureDetector(
                  onTap: () {},
                  child: const Text(
                    "Register here",
                    style: TextStyle(
                      color: Color(0xFFF5F5DD),
                      fontFamily: 'Inter',
                      fontSize: 14,
                      fontWeight: FontWeight.w200,
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(MaterialApp(
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xFF001A23),
      ),
      home: const LoginScreen()));
}
