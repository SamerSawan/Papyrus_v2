import 'package:flutter/material.dart';
import 'package:papyrus/core/api/book_service.dart';
import 'package:papyrus/core/models/book.dart';

class BookCard extends StatefulWidget {
  final Book book;

  const BookCard({
    super.key,
    required this.book,
  });

  @override
  State<BookCard> createState() => _BookCardState();
}

class _BookCardState extends State<BookCard> {
  BookService bookService = BookService();
  late Book book; // Declare book variable

  @override
  void initState() {
    super.initState();
    book = widget.book; // Access book from widget
  }

  @override
  Widget build(context) {
    return Center(
      child: SizedBox(
        width: 367,
        height: 157,
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.only(bottom: 8),
              width: 367.0,
              height: 150.0,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6),
                  color: const Color(0xFF53917E).withOpacity(0.5)),
              child: Row(
                children: [
                  const SizedBox(width: 15),
                  Container(
                    height: 127,
                    width: 80,
                    clipBehavior: Clip.hardEdge,
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(8)),
                    child: book.image.isNotEmpty
                        ? Image.network(book.image)
                        : const Placeholder(), // added const
                  ),
                  const SizedBox(width: 15),
                  Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 21),
                        SizedBox(
                          width: 200,
                          child: Text(
                            book.title,
                            textAlign: TextAlign.left,
                            style: const TextStyle(
                              color: Color.fromRGBO(245, 245, 221, 1),
                              fontFamily: 'Inter',
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Text(
                            book.authors.isNotEmpty
                                ? book.authors[0]
                                : 'Unknown Author',
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                                color: Color.fromRGBO(245, 245, 221, 1),
                                fontFamily: 'Inter',
                                fontSize: 12,
                                fontWeight: FontWeight.w400)),
                        const Text(
                          'Ratings',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Color.fromRGBO(245, 245, 221, 1),
                            fontFamily: 'Inter',
                            fontSize: 10,
                          ),
                        ),
                        Expanded(
                          child: SizedBox(
                            width: 230,
                            child: Text(
                              book.description,
                              textAlign: TextAlign.left,
                              softWrap: true,
                              maxLines: 4,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                color: Color.fromRGBO(245, 245, 221, 1),
                                fontFamily: 'Inter',
                                fontSize: 10,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                          ),
                        ),
                      ])
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
