import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:papyrus/core/api/book_service.dart';
import 'package:papyrus/core/models/book.dart';
import 'package:papyrus/core/models/book_club.dart';
import 'package:auto_size_text/auto_size_text.dart';

class BookTimeline extends StatefulWidget {
  final Book book;
  const BookTimeline({super.key, required this.book});

  @override
  State<BookTimeline> createState() => _BookTimelineState();
}

class _BookTimelineState extends State<BookTimeline> {
BookService bookService = BookService();
late Book book;

 @override
  void initState() {
    super.initState();
    book = widget.book; // Access book from widget
  }

  @override
  Widget build(context) {
    return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            margin: const EdgeInsets.only(bottom: 208, right: 20),
            width: 118,
            height: 26,
            child: Stack(
              alignment: Alignment.center, 
            children: [
              CustomPaint(
                painter: BookmarkChapterLeft(),
              ),
              const Text('Milestone #1',
                  style: TextStyle(
                      color: Color.fromARGB(255, 0, 0, 0),
                      fontSize: 10,
                      fontWeight: FontWeight.bold))
            ]),
          ),
          Stack(children: [
            Container(
                margin: const EdgeInsets.only(top: 20),
                width: 60,
                height: 350,
                color: const Color(0x8053917E)),
            Container(
                margin: const EdgeInsets.only(top: 80),
                width: 60,
                height: 113,
                color: const Color.fromRGBO(245, 245, 221, 1),
                child: Column(children: [
                    const SizedBox(height: 10),
                    AutoSizeText(book.title,
                        textAlign: TextAlign.center,
                        minFontSize: 8,
                        maxFontSize: 11,
                        maxLines: 2,
                        style: const TextStyle(
                            color: Color.fromARGB(255, 0, 0, 0),
                            height: 1.2,
                            fontWeight: FontWeight.bold)),
                    const SizedBox(height: 15),
                    AutoSizeText(book.authors.isNotEmpty
                                  ? book.authors[0]
                                  : 'Unknown Author',
                        textAlign: TextAlign.center,
                        minFontSize: 8,
                        maxFontSize: 11,
                        maxLines: 3,
                        style: const TextStyle(
                          color: Color.fromARGB(255, 0, 0, 0),
                        )),                    
                  ]),
                ),
              Container(
                margin: const EdgeInsets.only(top: 175, left: 14),
                child: const AutoSizeText('Papyrus',
                          textAlign: TextAlign.center,
                          minFontSize: 6,
                          maxFontSize: 8,
                          maxLines: 1,
                          style: TextStyle(
                            color: Color.fromARGB(255, 0, 0, 0),
                          )),
              )
            /*Container(
                margin: const EdgeInsets.only(top: 125, left: 14),
                alignment: Alignment.center,
                width: 32,
                height: 2,
                color: const Color(0xFFD35269))*/
          ]),
          Container(
            margin: const EdgeInsets.only(bottom: 130, left: 20),
            width: 118,
            height: 26,
            child: Stack(alignment: Alignment.center, children: [
              CustomPaint(
                painter: BookmarkChapterRight(),
              ),
              const Text('Milestone #2',
                  style: TextStyle(
                      color: Color.fromARGB(255, 0, 0, 0),
                      //height: 2.5,
                      fontFamily: 'Inter',
                      fontSize: 10,
                      fontWeight: FontWeight.bold))
            ]),
          )
        ]);
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
    path.lineTo(-40, 0);
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
    path.lineTo(40, 0);
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
