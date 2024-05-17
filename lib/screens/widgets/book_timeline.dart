import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:papyrus/core/api/firestore_service.dart';
import 'package:papyrus/core/models/book.dart';
import 'package:papyrus/core/models/comment.dart';

class BookTimeline extends StatefulWidget {
  final Book book;
  final String bookClubID;
  const BookTimeline({super.key, required this.book, required this.bookClubID});

  @override
  State<BookTimeline> createState() => _BookTimelineState();
}

class _BookTimelineState extends State<BookTimeline> {
  late int milestoneCount;
  late double stackHeight;

  Future<List<Comment>> getCommentList() async {
    Stream<QuerySnapshot> stream =
        await FirestoreService().getCommentsStream(widget.bookClubID);

    List<Comment> comments = [];
    stream.listen((snapshot) {
      final streams = snapshot.docs
          .map((doc) =>
              Comment.fromMap(doc.data() as Map<String, dynamic>, doc.id))
          .toList();
      comments.addAll(streams);
    });
    return comments;
  }

  @override
  void initState() {
    super.initState();
    milestoneCount = (widget.book.pageCount / 50).ceil();
    stackHeight = milestoneCount * 100.0;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Comment>>(
      future: getCommentList(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          List<Comment> comments = snapshot.data ?? [];

          // Initialize a set to store milestone indexes with comments
          Set<int> milestoneIndexesWithComments = {};

          // Iterate over comments to determine milestone indexes with comments
          for (var comment in comments) {
            int milestoneIndex =
                (comment.percentage * (milestoneCount - 1) / 100).floor();
            milestoneIndexesWithComments.add(milestoneIndex);
          }

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
                              margin:
                                  const EdgeInsets.only(right: 20, bottom: 10),
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
                            if (milestoneIndexesWithComments.contains(index))
                              const CircleAvatar(
                                radius: 15,
                                backgroundColor: Colors.blue,
                                child: Icon(Icons.comment,
                                    size: 15, color: Colors.white),
                              ),
                            const SizedBox(height: 50),
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
                              margin:
                                  const EdgeInsets.only(left: 20, bottom: 10),
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
                            if (milestoneIndexesWithComments.contains(index))
                              const CircleAvatar(
                                radius: 15,
                                backgroundColor: Colors.blue,
                                child: Icon(Icons.comment,
                                    size: 15, color: Colors.white),
                              ),
                            const SizedBox(height: 50),
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
      },
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
