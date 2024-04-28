import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    theme: ThemeData(
      scaffoldBackgroundColor: const Color(0xFF001A23),
    ),
    home: Scaffold(
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
            SizedBox(
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
                  labelText: 'Username',
                  labelStyle: TextStyle(
                      color: const Color(0xFF53917E)
                          .withOpacity(0.5)), // Placeholder text
                  filled: true,
                  fillColor: Colors.black26, // White background for text input
                  contentPadding: const EdgeInsets.symmetric(
                    vertical: 12.0,
                    horizontal: 16.0,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  ));
}
