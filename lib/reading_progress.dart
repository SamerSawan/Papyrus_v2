import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ReadingProgress extends StatelessWidget {
  const ReadingProgress({super.key});
  
  @override
  Widget build(context) {
     return Center(
      child: Column ( 
      children: [
       Container (
              margin: const EdgeInsets.only(top: 15),
        child: const Text(
          'See how everyone is doing.',
          style: TextStyle(
            color: Color.fromARGB(255, 245, 245, 221),
            fontFamily: 'Inter',
            fontWeight: FontWeight.bold,
            fontSize: 16,
          )
          )
       ),
         const SizedBox(height: 15),
Container(
              width: 367,
              height: 10,
              decoration: BoxDecoration(
                gradient: const LinearGradient(colors: [Color(0xFF001123), Color(0xFFD2F1E4), Color(0xFF001123)]
              ),
              borderRadius: BorderRadius.circular(6), 
   )
      ),
     Align(
      child: Container(
        margin: const EdgeInsets.only(top: 15),
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [ Text('0%',
          style: TextStyle(
            color: Color.fromARGB(255, 245, 245, 221),
            fontFamily: 'Inter',
            fontSize: 10,
          )
          )
          ,
          SizedBox(width: 340),
          Text('100%',
          style: TextStyle(
            color: Color.fromARGB(255, 245, 245, 221),
            fontFamily: 'Inter',
            fontSize: 10,
          )
          )
          ]
        )
      )
     )
        ],
        )
      )

     ;
  }
}