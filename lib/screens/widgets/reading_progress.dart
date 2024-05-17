import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:papyrus/core/models/book_club.dart';

class ReadingProgress extends StatelessWidget {
  final BookClub bookClub;
  const ReadingProgress({super.key, required this.bookClub});

  @override
  Widget build(context) {
    return Center(
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.only(top: 15),
            child: const Text(
              'See how everyone is doing.',
              style: TextStyle(
                color: Color.fromARGB(255, 245, 245, 221),
                fontFamily: 'Inter',
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ),
          const SizedBox(height: 15),
          SizedBox(
            height: 70,
            child: Stack(
              children: [
                Column(
                  children: [
                    Align(
                      child: Container(
                        margin: const EdgeInsets.only(bottom: 5),
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(left: 5),
                              child: Text(
                                '0%',
                                style: TextStyle(
                                  color: Color.fromARGB(255, 245, 245, 221),
                                  fontFamily: 'Inter',
                                  fontSize: 10,
                                ),
                              ),
                            ),
                            Spacer(),
                            Padding(
                              padding: EdgeInsets.only(right: 5),
                              child: Text(
                                '100%',
                                style: TextStyle(
                                  color: Color.fromARGB(255, 245, 245, 221),
                                  fontFamily: 'Inter',
                                  fontSize: 10,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      width: 367,
                      height: 10,
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(colors: [
                          Color(0xFF001123),
                          Color(0xFFD2F1E4),
                          Color(0xFF001123)
                        ]),
                        borderRadius: BorderRadius.circular(6),
                      ),
                    ),
                  ],
                ),
                ...bookClub.userProgressMap.entries.map(
                  (entry) {
                    final progress = entry.value.toDouble();
                    final position = (progress / 100) * 367;

                    return Positioned(
                      top: 32,
                      bottom: 0,
                      left: position.clamp(5, 367),
                      child: Column(
                        children: [
                          CustomPaint(
                            size: const Size(20, 10),
                            painter: TrianglePainter(),
                          ),
                          CircleAvatar(
                            radius: 10,
                            backgroundColor: Color(0xFF34ADBC),
                            child: Text(
                              entry.key[0].toUpperCase(),
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 10,
                              ), // Adjusted font size
                            ), // Customize as needed
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class TrianglePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Color(0xFF34ADBC) // Customize as needed
      ..style = PaintingStyle.fill;

    final path = Path()
      ..moveTo(0, size.height) // Start at the bottom left
      ..lineTo(size.width / 2, 0) // Top center
      ..lineTo(size.width, size.height) // Bottom right
      ..close(); // Close the path to complete the triangle

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
