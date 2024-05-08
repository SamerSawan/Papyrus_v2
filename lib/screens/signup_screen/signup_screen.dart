import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:papyrus/firebase_options.dart';
import 'package:papyrus/helper/helper_functions.dart';
import 'package:papyrus/screens/widgets/custom_button.dart';
import 'package:papyrus/screens/widgets/custom_text_input.dart';

class SignUpScreen extends StatefulWidget {
  final void Function()? onTap;

  const SignUpScreen({super.key, required this.onTap});

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

  void register() async {
    showDialog(
        context: context,
        builder: (context) => const Center(
              child: CircularProgressIndicator(),
            ));

    if (passwordController.text != confirmPasswordController.text) {
      Navigator.pop(context);

      displayMessageToUser("Passwords do not match", context);
      return;
    }

    try {
      UserCredential? userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: emailController.text, password: passwordController.text);

      Navigator.pop(context);
    } on FirebaseAuthException catch (e) {
      Navigator.pop(context);

      displayMessageToUser(e.code, context);
    }
  }

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
                label: "Email Adress",
                controller: emailController,
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
                controller: usernameController,
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
                controller: passwordController,
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
                controller: confirmPasswordController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter some text';
                  }
                  // You can add more validation logic here
                  return null; // Return null if the input is valid
                },
              ),
              const SizedBox(height: 20),
              CustomButton(text: 'Sign up', onTap: register),
              const SizedBox(height: 25),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Already have an account? ",
                    style: TextStyle(
                      color: Color(0xFFF5F5DD),
                      fontFamily: 'Inter',
                      fontSize: 14,
                      fontWeight: FontWeight.w200,
                    ),
                  ),
                  GestureDetector(
                    onTap: widget.onTap,
                    child: const Text(
                      " Login Here",
                      style: TextStyle(
                        color: Color(0xFFF5F5DD),
                        fontFamily: 'Inter',
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  )
                ],
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
    home: const Scaffold(body: Placeholder()),
  ));
}
