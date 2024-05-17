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
  @override
  Widget build(BuildContext context) {
    List<String> milestones = [
      'Milestone #1',
      'Milestone #2',
      'Milestone #3',
      'Milestone #4',
      'Milestone #5'
    ]; // Replace with your milestones data

    double leftMilestonesWidth =
        118.0 * ((milestones.length + 1) / 2).ceil().toDouble();
    double rightMilestonesWidth =
        118.0 * (milestones.length / 2).ceil().toDouble();
    double centralTimelineWidth = 60.0;
    double centralTimelineHeight = 100.0 * milestones.length - 20;

    // Calculate the total width of the central container
    double totalWidth =
        leftMilestonesWidth + centralTimelineWidth + rightMilestonesWidth;

    return Center(
      child: Container(
        width: totalWidth,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: List.generate(milestones.length, (index) {
                if (index % 2 == 0) {
                  return Container(
                    width: 118,
                    height: 26,
                    margin: const EdgeInsets.only(right: 20, bottom: 75),
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        CustomPaint(
                          painter: BookmarkChapterLeft(),
                        ),
                        Text(
                          milestones[index],
                          style: const TextStyle(
                            color: Color.fromARGB(255, 0, 0, 0),
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  );
                } else {
                  return const SizedBox(height: 50);
                }
              }),
            ),
            Stack(
              alignment: Alignment.topCenter,
              children: [
                Container(
                  margin: const EdgeInsets.only(top: 20),
                  width: 60,
                  height: centralTimelineHeight,
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
              children: List.generate(milestones.length, (index) {
                if (index % 2 != 0) {
                  return Container(
                    width: 118,
                    height: 26,
                    margin: const EdgeInsets.only(left: 20, bottom: 75),
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        CustomPaint(
                          painter: BookmarkChapterRight(),
                        ),
                        Text(
                          milestones[index],
                          style: const TextStyle(
                            color: Color.fromARGB(255, 0, 0, 0),
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  );
                } else {
                  return SizedBox(height: 50);
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
