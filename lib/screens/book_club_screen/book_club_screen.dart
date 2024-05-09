import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:papyrus/core/api/book_service.dart';
import 'package:papyrus/core/models/book.dart';
import 'package:papyrus/core/models/book_club.dart';
import 'package:papyrus/screens/widgets/book_card.dart';
import 'package:papyrus/screens/widgets/book_timeline.dart';
import 'package:papyrus/screens/widgets/reading_progress.dart';
import 'package:papyrus/screens/widgets/information_box.dart';
import 'package:papyrus/screens/widgets/description_box.dart';
import 'package:papyrus/screens/widgets/popup_update_progress.dart';

BookClub bookClub = BookClub(
  name: "shareholder pleasers",
  currentBook: "Anna Karenina",
  description: "Temporary Description",
  users: [],
);

class BookClubScreen extends StatefulWidget {
  const BookClubScreen({super.key});

  @override
  State<BookClubScreen> createState() => _BookClubScreenState();
}

class _BookClubScreenState extends State<BookClubScreen> {
  BookService bookService = BookService();
  late Future<Book> book = bookService.findBook(bookTitle: "Anna Karenina");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: const TestPop(),
      body: FutureBuilder<Book>(
        future: book,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            // While the book is loading, show a loading indicator
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            // If there's an error fetching the book, display an error message
            return Center(
              child: Text('Error loading book: ${snapshot.error}'),
            );
          } else {
            // If the book is successfully loaded, display the BookCard
            return ListView(
              children: [
                CupertinoNavigationBar(
                  middle: Text(
                    bookClub.name,
                    style: const TextStyle(
                      color: Color.fromRGBO(245, 245, 221, 1),
                      fontFamily: 'Inter',
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  leading: IconButton(
                    icon: const Icon(Icons.arrow_back_ios, color: Colors.grey),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                  backgroundColor: const Color(0xFF001A23),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    BookCard(
                        book: snapshot
                            .data!), // Use snapshot.data to access the loaded book
                    Align(
                      child: SizedBox(
                        width: 367,
                        height: 90,
                        child: Row(
                          children: [
                            DescriptionBox(description: bookClub.description),
                            const InformationBox(),
                          ],
                        ),
                      ),
                    ),
                    const ReadingProgress(),
                    const BookTimeline(),
                  ],
                ),
              ],
            );
          }
        },
      ),
    );
  }
}
