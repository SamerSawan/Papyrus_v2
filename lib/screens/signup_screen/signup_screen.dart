import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:papyrus/firebase_options.dart';
import 'package:papyrus/screens/widgets/custom_text_input.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  SignUpScreenState createState() => SignUpScreenState();
}

class SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();

  // text controllers
  TextEditingController usernameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  void register() {}

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
          width: 330,
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
              CustomTextInput(
                label: "Name",
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
                label: "Email Adress",
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
                label: "Username",
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter some text';
                  }
                  // You can add more validation logic here
                  return null; // Return null if the input is valid
                },
              ),
              const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Username requirements",
                    style: TextStyle(
                      color: Color(0x80F5F5DD),
                      fontFamily: 'Inter',
                      fontSize: 13,
                      fontWeight: FontWeight.w200,
                    ),
                  )),
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
              const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Password requirements",
                    style: TextStyle(
                      color: Color(0x80F5F5DD),
                      fontFamily: 'Inter',
                      fontSize: 13,
                      fontWeight: FontWeight.w200,
                    ),
                  )),
              const SizedBox(height: 20),
              CustomTextInput(
                label: "Confirm Password",
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter some text';
                  }
                  // You can add more validation logic here
                  return null; // Return null if the input is valid
                },
              ),
              const SizedBox(height: 20),
              const Text(
                "Create",
                style: TextStyle(
                  color: Color(0xFFF5F5DD),
                  fontFamily: 'Inter',
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                ),
              )
            ],
          )),
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
    home: const Scaffold(body: SignUpScreen()),
  ));
}
