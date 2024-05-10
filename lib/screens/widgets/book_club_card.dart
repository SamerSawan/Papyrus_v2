import 'package:flutter/material.dart';
import 'package:papyrus/core/api/book_service.dart';
import 'package:papyrus/core/models/book.dart';
import 'package:papyrus/core/models/book_club.dart';
import 'package:papyrus/screens/widgets/book_club_title.dart';

class BookClubCard extends StatefulWidget {
  final BookClub bookClub;
  const BookClubCard({super.key, required this.bookClub});

  @override
  State<BookClubCard> createState() => _BookClubCardState();
}

class _BookClubCardState extends State<BookClubCard> {
  @override
  Widget build(context) {
    return Column(
      children: [
        SizedBox(
          width: 367,
          child: Column(
            children: [
              Container(
                width: 367.0,
                height: 150.0,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6),
                    color: const Color.fromRGBO(83, 145, 126, 1).withOpacity(0.5)), // added const
                child: Row(
                  children: [
                    const SizedBox(width: 15),
                    Container(
                      height: 127,
                      width: 80,
                      clipBehavior: Clip.hardEdge,
                      decoration:
                          BoxDecoration(borderRadius: BorderRadius.circular(8)),
                      child: Image.network(widget.bookClub.currentBook.image),
                    ),
                    const SizedBox(width: 15),
                    Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 21),
                          BookClubTitle(name: widget.bookClub.name),
                          SizedBox(
                            width: 200,
                            child: Text(
                              '${widget.bookClub.currentBook.title} by ${widget.bookClub.currentBook.authors[0]}',
                              style: const TextStyle(
                                color: Color(0xFFF5F5DD),
                                fontFamily: 'Inter',
                                fontSize: 15,
                                fontWeight: FontWeight.w400,
                              ),
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
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
