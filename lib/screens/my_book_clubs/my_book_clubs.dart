import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:papyrus/core/api/firestore_service.dart';
import 'package:papyrus/core/models/book_club.dart';
import 'package:papyrus/screens/book_club_screen/book_club_screen.dart';
import 'package:papyrus/screens/choose_book_screen/choose_book_screen.dart';
import 'package:papyrus/screens/widgets/book_club_card.dart';
import 'package:papyrus/screens/widgets/custom_text_update.dart';
import 'package:papyrus/screens/widgets/search_bar_clubs.dart';

class MyBookClubs extends StatefulWidget {
  const MyBookClubs({super.key});

  @override
  State<MyBookClubs> createState() => _MyBookClubsState();
}

class _MyBookClubsState extends State<MyBookClubs> {
  FirestoreService firestoreService = FirestoreService();
  TextEditingController clubNameController = TextEditingController();
  TextEditingController clubDescriptionController = TextEditingController();
  List<Map<String, dynamic>> bookClubs = [];

  void logout() {
    FirebaseAuth.instance.signOut();
  }

  // Fetch book clubs when the screen initializes
  @override
  void initState() {
    super.initState();
    fetchBookClubs();
  }

  // Method to fetch book clubs using bookClubIds
  void fetchBookClubs() async {
    User? currentUser = FirebaseAuth.instance.currentUser;
    final docRef =
        FirebaseFirestore.instance.collection("Users").doc(currentUser?.email);
    docRef.get().then(
      (DocumentSnapshot doc) async {
        final data = doc.data() as Map<String, dynamic>;
        List<String> bookClubIds = List<String>.from(data['bookClubIds'] ?? []);

        // Fetch each book club using its ID
        List<Map<String, dynamic>> fetchedBookClubs = [];
        for (String id in bookClubIds) {
          BookClub? bookClub = await firestoreService.fetchBookClubById(id);
          if (bookClub != null) {
            fetchedBookClubs.add({'id': id, 'bookClub': bookClub});
          }
        }

        setState(() {
          bookClubs = fetchedBookClubs;
        });
      },
      onError: (e) => print("Error getting document: $e"),
    );
  }

  @override
  Widget build(context) {
    return Scaffold(
      appBar: CupertinoNavigationBar(
        middle: Text(
          'My Book Clubs',
          style: Theme.of(context).textTheme.titleMedium, // changed style
        ),
        backgroundColor: const Color(0xFF001A23),
        leading: IconButton(onPressed: logout, icon: const Icon(Icons.logout)),
        trailing: IconButton(
            onPressed: () {
              showDialog<void>(
                context: context,
                builder: (context) => AlertDialog(
                  insetPadding: const EdgeInsets.all(10),
                  contentPadding: const EdgeInsets.all(10),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadiusDirectional.circular(11)),
                  backgroundColor: const Color.fromARGB(255, 210, 241, 228),
                  content: Stack(
                    children: [
                      SizedBox(
                        height: 215,
                        width: 320,
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: const Text('Cancel',
                                      style: TextStyle(
                                        fontSize: 15,
                                        color: Color.fromARGB(255, 0, 0, 0),
                                      )),
                                ),
                                TextButton(
                                  child: const Text('Submit',
                                      style: TextStyle(
                                        fontSize: 15,
                                        color: Color.fromARGB(255, 0, 0, 0),
                                      )),
                                  onPressed: () {
                                    Navigator.of(context)
                                        .push(CupertinoPageRoute(
                                      builder: (context) => ChooseBookScreen(
                                        bookClubName: clubNameController.text,
                                        description:
                                            clubDescriptionController.text,
                                        onClubCreated: fetchBookClubs,
                                      ),
                                    ));
                                  },
                                )
                              ],
                            ),
                            const Text(
                              'Create a new book club',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Color.fromARGB(255, 0, 0, 0),
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 10),
                            CustomTextUpdate(
                              label: 'Name',
                              controller: clubNameController,
                              validator: (value) {
                                return null;
                              },
                              height: 35,
                            ),
                            const SizedBox(height: 10),
                            CustomTextUpdate(
                              label: 'Description',
                              controller: clubDescriptionController,
                              validator: (value) {
                                return null;
                              },
                              height: 75,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
            icon: const Icon(Icons.add)),
      ),
      body: Column(
        children: [
          SizedBox(
            width: 367,
            child: SearchTextField(
              searchController: TextEditingController(),
              hintText: "Search by title or ISBN",
              onChanged: (String) {},
            ),
          ),
          Expanded(
            child: bookClubs.isEmpty
                ? Center(child: Text('No book clubs found'))
                : ListView.builder(
                    itemCount: bookClubs.length,
                    itemBuilder: (context, index) {
                      final bookClub = bookClubs[index]['bookClub'];
                      return CupertinoButton(
                        child: BookClubCard(bookClub: bookClub),
                        onPressed: () {
                          Navigator.of(context).push(
                            CupertinoPageRoute(
                              builder: (context) => BookClubScreen(
                                bookClub: bookClub,
                                bookClubID: bookClubs[index]['id'],
                              ),
                            ),
                          );
                        },
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
