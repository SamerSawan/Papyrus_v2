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

class ChooseBookScreen extends StatefulWidget {
  const ChooseBookScreen({super.key});

  @override
  State<ChooseBookScreen> createState() => _ChooseBookScreenState();
}

class _ChooseBookScreenState extends State<ChooseBookScreen> {
  TextEditingController searchController = TextEditingController();
  BookService bookService = BookService();
  List<Book> searchResults = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          CupertinoNavigationBar(
            middle: const Text(
              "Choose a book for your club",
              style: TextStyle(
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
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: CupertinoSearchTextField(
              controller: searchController,
              placeholder: "Search by Title or Author",
              itemColor: const Color.fromARGB(121, 245, 245, 221),
              style: const TextStyle(color: Color(0xFFF5F5DD)),
              onChanged: (value) async {
                if (value.isNotEmpty) {
                  final results = await bookService.searchBooksByQuery(value);
                  setState(() {
                    searchResults = results;
                  });
                } else {
                  setState(() {
                    searchResults = [];
                  });
                }
              },
            ),
          ),
          Flexible(
            child: FutureBuilder<List<Book>>(
              future: bookService.searchBooksByQuery(searchController.text),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (snapshot.hasError) {
                  return Center(
                    child: Text('Error: ${snapshot.error}'),
                  );
                } else {
                  final List<Book>? books = snapshot.data;
                  if (books != null && books.isNotEmpty) {
                    return ListView.builder(
                      padding: EdgeInsets.zero,
                      itemCount: books.length,
                      itemBuilder: (context, index) {
                        return BookCard(book: books[index]);
                      },
                    );
                  } else {
                    // Handle case when snapshot data is null or empty
                    return const Center(
                      child: Text('No books found.'),
                    );
                  }
                }
              },
            ),
          )
        ],
      ),
    );
  }
}
