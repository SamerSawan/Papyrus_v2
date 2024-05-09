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

BookClub bookClub = BookClub(
  name: "Shareholder Pleasers",
  currentBook: Book(
    title: "Anna Karenina",
    authors: ["Leo Tolstoy"],
    isbns: ["1"],
    description:
        "Love... it means too much to me, far more than you can understand.At its simplest, Anna Karenina is a love story. It is a portrait of a beautiful and intelligent woman whose passionate love for a handsome officer sweeps aside all other ties - to her marriage and to the network of relationships and moral values that bind the society around her. The love affair of Anna and Vronsky is played out alongside the developingromance of Kitty and Levin, and in the character of Levin, closely based on Tolstoy himself, the search for happiness takes on a deeper philosophical significance. One of the greatest novels ever written,Anna Karenina combines penetrating psychological insight with",
    pageCount: 896,
    categories: [],
    image:
        'https://books.google.ca/books?id=1DooDwAAQBAJ&printsec=frontcover&source=gbs_ge_summary_r&cad=0',
  ),
  description: 'silly group',
  users: [],
);

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

  @override
  Widget build(context) {
    return Scaffold(
      body: ListView(children: [
        CupertinoNavigationBar(
          middle: const Text(
            'My Book Clubs',
            style: TextStyle(
              color: Color(0xFFF5F5DD),
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          backgroundColor: const Color(0xFF001A23),
          leading:
              IconButton(onPressed: logout, icon: const Icon(Icons.logout)),
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
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
                                            bookClubName:
                                                clubNameController.text,
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
        ), // need to find a good place for this
        Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                  width: 367,
                  child: SearchTextField(
                    searchController: TextEditingController(),
                    hintText: "Search by title or ISBN",
                    onChanged: (String) {},
                  )),
              CupertinoButton(
                child: const BookClubCard(),
                onPressed: () {
                  Navigator.of(context).push(
                    CupertinoPageRoute(
                      builder: (context) => BookClubScreen(
                        bookClub: bookClub,
                      ),
                    ),
                  );
                },
              ),
            ])
      ]),
    );
  }
}
