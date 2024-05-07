import 'package:flutter/material.dart';
import 'package:papyrus/core/services/book_service.dart';
import 'package:papyrus/core/models/book.dart';
import 'package:papyrus/core/models/book_club.dart';
import 'package:papyrus/screens/widgets/book_club_title.dart';

BookClub bookClub = BookClub(
  name: "shareholder pleasers",
  currentBook: "Anna Karenina",
  description: "Temporary Description",
  users: [],
);

class BookClubCard extends StatefulWidget {
  const BookClubCard({super.key});

  @override
  State<BookClubCard> createState() => _BookClubCardState();
}

class _BookClubCardState extends State<BookClubCard> {
  late Future<Book> futureBook;
  BookService bookService = BookService();

  @override
  void initState() {
    super.initState();
    futureBook = bookService.searchBooks(bookTitle: 'Anna Karenina');
  }

  @override
  Widget build(context) {
    return Column(children: [
      SizedBox(
          width: 367,
          child: Column(children: [
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
                          const SizedBox(width: 15),
                          Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(height: 21),
                                BookClubTitle(name: bookClub.name),
                                Text(
                                  '${bookClub.currentBook} by ${book.authors[0]}',
                                  style: const TextStyle(
                                    color: Color(0xFFF5F5DD),
                                    fontFamily: 'Inter',
                                    fontSize: 15,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                const Text(
                                  'Ratings',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Color.fromRGBO(245, 245, 221, 1),
                                    fontFamily: 'Inter',
                                    fontSize: 10,
                                  ),
                                ),
                                const SizedBox(
                                  height: 2,
                                ),
                                const Text(
                                  'Created by [User]',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Color.fromRGBO(245, 245, 221, 1),
                                    fontFamily: 'Inter',
                                    fontSize: 10,
                                  ),
                                ),
                                const Text(
                                  'Participants : #',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Color.fromRGBO(245, 245, 221, 1),
                                    fontFamily: 'Inter',
                                    fontSize: 10,
                                  ),
                                ),
                                const Text(
                                  'Date Started: DD/MM/YY',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Color.fromRGBO(245, 245, 221, 1),
                                    fontFamily: 'Inter',
                                    fontSize: 10,
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
                    return const Center(
                        child: SizedBox(
                            width: 30,
                            height: 30,
                            child: CircularProgressIndicator(
                              color: Color.fromRGBO(245, 245, 221, 0.464),
                              strokeWidth: 1,
                            )));
                  },
                ))
          ]))
    ]);
  }
}
