import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:papyrus/screens/widgets/custom_text_input.dart';

void main() {
  runApp(MaterialApp(
    theme: ThemeData(
      scaffoldBackgroundColor: const Color(0xFF001A23),
    ),
    home: Scaffold(
      body: Center(
        child: SizedBox(
          width:330,
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
            const CustomTextInput(label: "Name"),
            const SizedBox(height: 20),
            const CustomTextInput(label: "Email Adress"),
            const SizedBox(height: 20),
            const CustomTextInput(label: "Username"),
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
              "Username requirements",
              style: TextStyle( 
                color:  Color(0x80F5F5DD),
                fontFamily: 'Inter',
                fontSize: 13,
                fontWeight: FontWeight.w200,
              ),
            )),
            const SizedBox(height: 20),
            const CustomTextInput(label: "Password"),
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
              "Password requirements",
              style: TextStyle( 
                color:  Color(0x80F5F5DD),
                fontFamily: 'Inter',
                fontSize: 13,
                fontWeight: FontWeight.w200,
              ),
            )),
            const SizedBox(height: 20),
            const CustomTextInput(label: "Confirm Password"),
            const SizedBox(height: 20),
            const Text(
              "Create",
              style: TextStyle( 
                color:  Color(0xFFF5F5DD),
                fontFamily: 'Inter',
                fontSize: 13,
                fontWeight: FontWeight.w500,
              ),
            )
          ],
        )),
      ),
    ),
  ));
}
