import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class BookTimeline extends StatelessWidget {
  const BookTimeline({super.key});

  @override
  Widget build(context) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
          Container(
          margin: const EdgeInsets.only(bottom:208, right: 20),
          width: 118,
          height: 26,
          child: Stack(
            alignment: Alignment.center,
            children: [
            CustomPaint(
            painter: BookmarkChapterLeft(),
          ),
          const Text('Chapter 1',
        style: TextStyle(
            color: Color.fromARGB(255, 0, 0, 0),
            fontFamily: 'Inter',
            fontSize: 10,
            fontWeight: FontWeight.bold
          )
          )
            ]
          ),
        ),
    Stack(
children: [
Container(
  margin: const EdgeInsets.only(top: 20),
  width: 60,
  height: 350,
  color: const Color(0x8053917E)
              ), 
Container(
  margin: const EdgeInsets.only(top: 80),
  width: 60,
  height: 113,
  color: const Color.fromRGBO(245, 245, 221, 1),
  child: const Column( 
    children: [Text('The Secret History',
      textAlign: TextAlign.center,
        style: TextStyle(
            color: Color.fromARGB(255, 0, 0, 0),
            height:1.2,
            fontFamily: 'Inter',
            fontSize: 11,
            fontWeight: FontWeight.bold
          )
          ), 
          SizedBox(height: 20),
          Text('Donna Tartt',
      textAlign: TextAlign.center,
        style: TextStyle(
            color: Color.fromARGB(255, 0, 0, 0),
            fontFamily: 'Inter',
            fontSize: 11,
          )
          ),
          SizedBox(height: 8),
          Text('Papyrus',
      textAlign: TextAlign.center,
        style: TextStyle(
            color: Color.fromARGB(255, 0, 0, 0),
            fontFamily: 'Inter',
            fontSize: 8,
          )
          )        
          ]   
           )
),
Container(
  margin: const EdgeInsets.only(top: 130, left: 14),
  alignment: Alignment.center,
  width: 32,
  height: 2,
  color: const Color(0xFFD35269)
)
]
      ),
        Container(
          margin: const EdgeInsets.only(bottom:130, left:20),
          width: 118,
          height: 26,
          child: Stack(
             alignment: Alignment.center,
            children: [CustomPaint(
            painter: BookmarkChapterRight(),
          ),
          const Text('Chapter 2',
        style: TextStyle(
            color: Color.fromARGB(255, 0, 0, 0),
            //height: 2.5,
            fontFamily: 'Inter',
            fontSize: 10,
            fontWeight: FontWeight.bold
          )
          )
            ]
          ),
        )
        ]
      );
}
}

class BookmarkChapterLeft extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()
      ..color = const Color(0xFFF5F5DD)
      ..strokeWidth = 1;

    final path = Path();

    path.moveTo(-59, -13);
    path.lineTo(59, -13);
    path.lineTo(59, 13);
    path.lineTo(-59, 13);
    path.lineTo(-35, 0);
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}

class BookmarkChapterRight extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()
      ..color = const Color(0xFFF5F5DD)
      ..strokeWidth = 1;

    final path = Path();

    path.moveTo(-59, 13);
    path.lineTo(59, 13);
    path.lineTo(35, 0);
    path.lineTo(59, -13);
    path.lineTo(-59, -13);
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}