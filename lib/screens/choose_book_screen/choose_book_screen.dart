import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:papyrus/core/api/book_service.dart';
import 'package:papyrus/core/models/book.dart';
import 'package:papyrus/core/models/book_club.dart';
import 'package:papyrus/screens/widgets/book_card.dart';

class ChooseBookScreen extends StatefulWidget {
  final String bookClubName;
  final String description;
  final VoidCallback onClubCreated;
  const ChooseBookScreen(
      {super.key,
      required this.bookClubName,
      required this.description,
      required this.onClubCreated});

  @override
  State<ChooseBookScreen> createState() => _ChooseBookScreenState();
}

class _ChooseBookScreenState extends State<ChooseBookScreen> {
  TextEditingController searchController = TextEditingController();
  BookService bookService = BookService();
  List<Book> searchResults = [];

  Future<String> createBookClubDocument(BookClub newClub) async {
    try {
      DocumentReference docRef = await FirebaseFirestore.instance
          .collection("BookClubs")
          .add(newClub.toMap());
      // Get the ID of the newly added document
      String docId = docRef.id;
      // Update the document with the ID
      await docRef.update({'id': docId});
      return docId; // Return the ID of the newly created BookClub
    } catch (e) {
      print("Error creating book club document: $e");
      // Handle error here
      return ''; // Return empty string in case of error
    }
  }

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
                        return CupertinoButton(
                            padding: EdgeInsets.zero,
                            onPressed: () {
                              showDialog<void>(
                                context: context,
                                builder: (context) => AlertDialog(
                                  insetPadding: const EdgeInsets.all(10),
                                  contentPadding: const EdgeInsets.all(10),
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadiusDirectional.circular(11)),
                                  backgroundColor:
                                      const Color.fromARGB(255, 210, 241, 228),
                                  content: Stack(
                                    children: [
                                      SizedBox(
                                        height: 215,
                                        width: 320,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                TextButton(
                                                  onPressed: () {
                                                    Navigator.of(context).pop();
                                                  },
                                                  child: const Text('Cancel',
                                                      style: TextStyle(
                                                        fontSize: 15,
                                                        color: Color.fromARGB(
                                                            255, 0, 0, 0),
                                                      )),
                                                ),
                                                TextButton(
                                                  child: const Text('Confirm',
                                                      style: TextStyle(
                                                        fontSize: 15,
                                                        color: Color.fromARGB(
                                                            255, 0, 0, 0),
                                                      )),
                                                  onPressed: () async {
                                                    BookClub newClub = BookClub(
                                                      name: widget.bookClubName,
                                                      description:
                                                          widget.description,
                                                      currentBook: books[index],
                                                      users: [],
                                                    );
                                                    // Create the BookClub document and get its ID
                                                    String bookClubId =
                                                        await createBookClubDocument(
                                                            newClub);

                                                    // Add the BookClub ID to the user's document
                                                    User? currentUser =
                                                        FirebaseAuth.instance
                                                            .currentUser;
                                                    final docRef =
                                                        FirebaseFirestore
                                                            .instance
                                                            .collection("Users")
                                                            .doc(currentUser
                                                                ?.email);
                                                    await docRef.get().then(
                                                      (DocumentSnapshot doc) {
                                                        final data = doc.data()
                                                            as Map<String,
                                                                dynamic>;
                                                        List<String>
                                                            newBookClubIds =
                                                            List<String>.from(
                                                                data['bookClubIds'] ??
                                                                    []);
                                                        newBookClubIds
                                                            .add(bookClubId);
                                                        FirebaseFirestore
                                                            .instance
                                                            .collection("Users")
                                                            .doc(currentUser
                                                                ?.email)
                                                            .update({
                                                          'bookClubIds':
                                                              newBookClubIds,
                                                        });
                                                      },
                                                      onError: (e) => print(
                                                          "Error getting document: $e"),
                                                    );

                                                    widget.onClubCreated();

                                                    Navigator.of(context)
                                                        .popUntil((route) =>
                                                            route.isFirst);
                                                  },
                                                )
                                              ],
                                            ),
                                            const Center(
                                              child: Text(
                                                'Confirm your new book club',
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                    color: Color.fromARGB(
                                                        255, 0, 0, 0),
                                                    fontSize: 14,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                            const SizedBox(height: 10),
                                            Row(
                                              children: [
                                                Container(
                                                  height: 127,
                                                  width: 80,
                                                  clipBehavior: Clip.hardEdge,
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8)),
                                                  child: books[index]
                                                          .image
                                                          .isNotEmpty
                                                      ? Image.network(
                                                          books[index].image)
                                                      : const Placeholder(),
                                                ),
                                                const SizedBox(width: 20),
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Row(
                                                      children: [
                                                        const Text(
                                                          "Name: ",
                                                          style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                          ),
                                                        ),
                                                        Text(
                                                            widget.bookClubName)
                                                      ],
                                                    ),
                                                    const SizedBox(height: 10),
                                                    Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        const Text(
                                                          "Description:",
                                                          style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                          ),
                                                        ),
                                                        Text(
                                                            widget.description),
                                                      ],
                                                    )
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                            child: BookCard(book: books[index]));
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
