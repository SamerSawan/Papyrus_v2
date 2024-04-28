import 'package:flutter/material.dart';
import 'package:papyrus/core/api/book_service.dart';
import 'package:papyrus/core/models/book.dart';

class BookCard extends StatefulWidget {
  const BookCard({super.key});

  @override
  State<BookCard> createState() => _BookCardState();
}

class _BookCardState extends State<BookCard> {
  late Future<Book> futureBook;
  BookService bookService = BookService();

  @override
  void initState() {
    super.initState();
    futureBook = bookService.searchBooks(bookTitle: 'Anna Karenina');
  }

  @override
  Widget build(context) {
    return Center(
        child: SizedBox(
            width: 367,
            height: 167,
            child: Column(children: [
              const SizedBox(height: 10),
              Container(
                  width: 367.0,
                  height: 150.0,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6),
                      color: const Color(0xFF53917E).withOpacity(0.5)),
                  child: FutureBuilder(
                    future: futureBook,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        final book = snapshot.data;
                        if (book != null) {
                          return Row(children: [
                            const SizedBox(width: 15),
                            Container(
                              height: 127,
                              width: 80,
                              clipBehavior: Clip.hardEdge,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8)),
                              child: Image.network(book.image),
                            ),

                            const SizedBox(
                                width: 15),
                            Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SizedBox(height: 21),
                                  Text(book.title,
                                      textAlign: TextAlign.center,
                                      style: const TextStyle(
                                          color:
                                              Color.fromRGBO(245, 245, 221, 1),
                                          fontFamily: 'Inter',
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold)),
                                  Text(book.authors[0],
                                      textAlign: TextAlign.center,
                                      style: const TextStyle(
                                          color:
                                              Color.fromRGBO(245, 245, 221, 1),
                                          fontFamily: 'Inter',
                                          fontSize: 12,
                                          fontWeight: FontWeight.w200)),
                                  const Text(
                                    'Ratings',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: Color.fromRGBO(245, 245, 221, 1),
                                      fontFamily: 'Inter',
                                      fontSize: 10,
                                    ),
                                  ),
                                  SizedBox(
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
                                ])
                          ]);
                        } else {
                          return const Text('No Book Data');
                        }
                      } else if (snapshot.hasError) {
                        return Text('$snapshot.error');
                      }
                      return const Center (
                        child: SizedBox (
                        width:30,
                        height:30,
                        child: CircularProgressIndicator(
                         color: Color.fromRGBO(245, 245, 221, 0.464),
                         strokeWidth: 1,
                      )
                      ));
                    },
                  ))
            ])));
  }
}
