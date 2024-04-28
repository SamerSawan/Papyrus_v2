import 'package:flutter/material.dart';

class CustomTextInput extends StatelessWidget {
  final String label;

  const CustomTextInput({super.key, required this.label});

  @override
  Widget build(context) {
    return SizedBox(
      width: 330,
      height: 40,
      child: TextFormField(
        cursorColor: Colors.white,
        style: const TextStyle(color: Colors.white),
        decoration: InputDecoration(
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(11.0),
            borderSide: BorderSide(
              color: const Color(0xFF53917E).withOpacity(0.5),
            ),
          ),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15.0),
              borderSide: BorderSide.none),
          labelText: label,
          labelStyle: TextStyle(
              color:
                  const Color(0xFF53917E).withOpacity(0.5)), // Placeholder text
          filled: true,
          fillColor: Colors.black26, // White background for text input
          contentPadding: const EdgeInsets.symmetric(
            vertical: 12.0,
            horizontal: 16.0,
          ),
        ),
      ),
    );
  }
}
