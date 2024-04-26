import 'package:flutter/material.dart';

class BookCard extends StatelessWidget {
  const BookCard({super.key});

  @override
  Widget build(context) {
    return Center(
      child: SizedBox (
        width: 367,
        height: 190,
        child: Column(
          children: [
            const Text('Book Club Name',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                      color: Color.fromRGBO(245, 245, 221, 1),
                      fontFamily: 'Inter',
                      fontSize: 16,
                      fontWeight: FontWeight.bold
                        )
                        ),
              const SizedBox(height:10),
              Container(
              width: 367.0,
              height: 150.0,
              decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6),
              color: const Color(0xFF53917E).withOpacity(0.5)
              ),
              child: const Row(
                children: [SizedBox(width: 183.5), // replace sizedbox with book image
                    Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height:21),
                      Text('Title',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                      color: Color.fromRGBO(245, 245, 221, 1),
                      fontFamily: 'Inter',
                      fontSize: 16,
                      fontWeight: FontWeight.bold
                        )
                        ),
                      Text('Author',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                      color: Color.fromRGBO(245, 245, 221, 1),
                      fontFamily: 'Inter',
                      fontSize: 12,
                      fontWeight: FontWeight.w200
                        )
                        ),
                      Text('Ratings',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                      color: Color.fromRGBO(245, 245, 221, 1),
                      fontFamily: 'Inter',
                      fontSize: 10,
                        )
                        ),
                      Text('Description',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                      color: Color.fromRGBO(245, 245, 221, 1),
                      fontFamily: 'Inter',
                      fontSize: 10,
                      fontWeight: FontWeight.w800
                        )
                        )     
                        ]
              )
              ]
              )
              )
              ]
              )
              )
              );
  }
}