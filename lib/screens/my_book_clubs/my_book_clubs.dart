import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:papyrus/core/models/book.dart';
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
  TextEditingController clubNameController = TextEditingController();
  TextEditingController clubDescriptionController = TextEditingController();

  void logout() {
    FirebaseAuth.instance.signOut();
  }

  Future<List<BookClub>> getBookClubs() async {
    User? currentUser = FirebaseAuth.instance.currentUser;
    final docRef =
        FirebaseFirestore.instance.collection("Users").doc(currentUser?.email);
    final DocumentSnapshot doc = await docRef.get();
    final data = doc.data() as Map<String, dynamic>;
    List<BookClub> bookClubs = data['bookClubs'].map<BookClub>((clubMap) {
      return BookClub.fromMap(clubMap);
    }).toList();
    return bookClubs;
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
                                              clubDescriptionController.text),
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
            child: FutureBuilder<List<BookClub>>(
              future: getBookClubs(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CupertinoActivityIndicator()); // added const
                } else if (snapshot.hasError || snapshot.data == null) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else {
                  return ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      final bookClub = snapshot.data![index];
                      return CupertinoButton(
                        child: BookClubCard(bookClub: bookClub),
                        onPressed: () {
                          Navigator.of(context).push(
                            CupertinoPageRoute(
                              builder: (context) => BookClubScreen(
                                bookClub: bookClub,
                              ),
                            ),
                          );
                        },
                      );
                    },
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
