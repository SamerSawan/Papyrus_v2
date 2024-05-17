import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:papyrus/core/models/book.dart';

class BookTimeline extends StatefulWidget {
  final Book book;
  const BookTimeline({Key? key, required this.book}) : super(key: key);

  @override
  State<BookTimeline> createState() => _BookTimelineState();
}

class _BookTimelineState extends State<BookTimeline> {
  late int milestoneCount;

  @override
  void initState() {
    super.initState();
    milestoneCount = widget.book.pageCount ~/ 50;
  }

  @override
  Widget build(BuildContext context) {
    double stackHeight = milestoneCount * 100.0; // Adjust the height as needed

    return Center(
      child: Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: List.generate(milestoneCount, (index) {
                if (index % 2 == 0) {
                  return Column(
                    children: [
                      Container(
                        width: 118,
                        height: 26,
                        margin: const EdgeInsets.only(right: 20, bottom: 10),
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            CustomPaint(
                              painter: BookmarkChapterLeft(),
                            ),
                            Text(
                              'Milestone #${index + 1}',
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                color: Color.fromARGB(255, 0, 0, 0),
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const CircleAvatar(
                        radius: 15,
                        backgroundColor: Colors.blue,
                        child:
                            Icon(Icons.comment, size: 15, color: Colors.white),
                      ),
                      const SizedBox(height: 25),
                    ],
                  );
                } else {
                  return const SizedBox(
                      height:
                          100); // Double the height to account for avatar and spacing
                }
              }),
            ),
            Stack(
              alignment: Alignment.topCenter,
              children: [
                Container(
                  margin: const EdgeInsets.only(top: 20),
                  width: 60,
                  height: stackHeight,
                  color: const Color(0x8053917E),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 80),
                  width: 60,
                  height: 113,
                  color: const Color.fromRGBO(245, 245, 221, 1),
                  child: Column(children: [
                    const SizedBox(height: 10),
                    AutoSizeText(widget.book.title,
                        textAlign: TextAlign.center,
                        overflow: TextOverflow.ellipsis,
                        minFontSize: 8,
                        maxFontSize: 11,
                        maxLines: 2,
                        style: const TextStyle(
                            color: Color.fromARGB(255, 0, 0, 0),
                            height: 1.2,
                            fontWeight: FontWeight.bold)),
                    const SizedBox(height: 15),
                    AutoSizeText(
                        widget.book.authors.isNotEmpty
                            ? widget.book.authors[0]
                            : 'Unknown Author',
                        textAlign: TextAlign.center,
                        overflow: TextOverflow.ellipsis,
                        minFontSize: 8,
                        maxFontSize: 11,
                        maxLines: 3,
                        style: const TextStyle(
                          color: Color.fromARGB(255, 0, 0, 0),
                        )),
                  ]),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 175),
                  child: const AutoSizeText('Papyrus',
                      textAlign: TextAlign.center,
                      minFontSize: 6,
                      maxFontSize: 8,
                      maxLines: 1,
                      style: TextStyle(
                        color: Color.fromARGB(255, 0, 0, 0),
                      )),
                )
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: List.generate(milestoneCount, (index) {
                if (index % 2 != 0) {
                  return Column(
                    children: [
                      Container(
                        width: 118,
                        height: 26,
                        margin: const EdgeInsets.only(left: 20, bottom: 10),
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            CustomPaint(
                              painter: BookmarkChapterRight(),
                            ),
                            Text(
                              'Milestone #${index + 1}',
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                color: Color.fromARGB(255, 0, 0, 0),
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const CircleAvatar(
                        radius: 15,
                        backgroundColor: Colors.blue,
                        child:
                            Icon(Icons.comment, size: 15, color: Colors.white),
                      ),
                      const SizedBox(height: 25),
                    ],
                  );
                } else {
                  return const SizedBox(
                      height:
                          100); // Double the height to account for avatar and spacing
                }
              }),
            ),
          ],
        ),
      ),
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
