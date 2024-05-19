import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:papyrus/core/api/firestore_service.dart';
import 'package:papyrus/core/models/book.dart';
import 'package:papyrus/core/models/comment.dart';
import 'package:papyrus/screens/single_comment_screen/single_comment_screen.dart';

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

  @override
  void initState() {
    super.initState();
    milestoneCount = (widget.book.pageCount / 50).ceil();
    stackHeight = (milestoneCount * 100.0)
        .clamp(100.0, double.infinity); // Ensure it's at least 100.0
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirestoreService().getCommentsStream(widget.bookClubID),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else if (!snapshot.hasData) {
          return const Text('No comments available');
        } else {
          List<Comment> comments = snapshot.data!.docs
              .map((doc) =>
                  Comment.fromMap(doc.data() as Map<String, dynamic>, doc.id))
              .toList();

          // Initialize a map to store milestone indexes with their usernames
          Map<int, List<Comment>> milestoneUsernames = {};

          // Iterate over comments to determine milestone indexes with usernames
          for (var comment in comments) {
            int milestoneIndex =
                (comment.percentage * (milestoneCount - 1) / 100).floor();
            if (!milestoneUsernames.containsKey(milestoneIndex)) {
              milestoneUsernames[milestoneIndex] = [];
            }
            milestoneUsernames[milestoneIndex]!.add(comment);
          }

          return Center(
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
                          if (milestoneUsernames.containsKey(index))
                            Padding(
                              padding: const EdgeInsets.only(right: 24.0),
                              child: Column(
                                children: [
                                  for (var chunk in _chunkList(
                                      milestoneUsernames[index]!, 3))
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: chunk.map((comment) {
                                        return Padding(
                                          padding: const EdgeInsets.all(4.0),
                                          child: GestureDetector(
                                            onTap: () {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      SingleCommentScreen(
                                                          comment: comment,
                                                          bookClubID: widget
                                                              .bookClubID),
                                                ),
                                              );
                                            },
                                            child: CircleAvatar(
                                              radius: 15,
                                              backgroundColor:
                                                  const Color(0xFF34ADBC),
                                              child: Text(
                                                comment.username[0]
                                                    .toUpperCase(),
                                                style: const TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 15),
                                              ),
                                            ),
                                          ),
                                        );
                                      }).toList(),
                                    ),
                                ],
                              ),
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
                      height: stackHeight > 0
                          ? stackHeight
                          : 100, // Ensure valid height
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
                          if (milestoneUsernames.containsKey(index))
                            Padding(
                              padding: const EdgeInsets.only(left: 24.0),
                              child: Column(
                                children: [
                                  for (var chunk in _chunkList(
                                      milestoneUsernames[index]!, 3))
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: chunk.map((comment) {
                                        return Padding(
                                          padding: const EdgeInsets.all(4.0),
                                          child: CircleAvatar(
                                            radius: 15,
                                            backgroundColor:
                                                const Color(0xFF34ADBC),
                                            child: Text(
                                              comment.username[0].toUpperCase(),
                                              style: const TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 15),
                                            ),
                                          ),
                                        );
                                      }).toList(),
                                    ),
                                ],
                              ),
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
          );
        }
      },
    );
  }

  List<List<T>> _chunkList<T>(List<T> list, int chunkSize) {
    List<List<T>> chunks = [];
    for (var i = 0; i < list.length; i += chunkSize) {
      chunks.add(list.sublist(
          i, i + chunkSize > list.length ? list.length : i + chunkSize));
    }
    return chunks;
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
