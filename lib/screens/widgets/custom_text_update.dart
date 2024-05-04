import 'package:flutter/material.dart';

void main() {
  runApp(
  const MaterialApp( 
      home: Scaffold(body: Center(child: CustomTextUpdate(label:'Add a comment...')))));}

class CustomTextUpdate extends StatelessWidget {
  final String label;

  const CustomTextUpdate({super.key, required this.label});

  @override
  Widget build(context) {
    return SizedBox(
      width: 330,
      height: 40,
      child: TextFormField(
        cursorHeight: 20,
        cursorColor: Colors.black,
        style: const TextStyle(color: Colors.white),
        decoration: InputDecoration(
         focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(11.0),
          ),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15.0),
              borderSide: BorderSide.none
              ),
              floatingLabelBehavior: FloatingLabelBehavior.never,
              labelText: label,
              labelStyle: TextStyle(
              color:
                  const Color.fromARGB(255, 0, 0, 0).withOpacity(0.5)), // Placeholder text
              filled: true,
              fillColor: Colors.black26, // White background for text input
         // contentPadding: const EdgeInsets.symmetric(vertical: 12.0,horizontal: 16.0,),
        ),
      ),
    );
  }
}
