import 'package:flutter/material.dart';
import 'package:papyrus/core/models/book.dart';
import 'package:papyrus/core/models/user.dart';
import 'package:papyrus/core/models/book_club.dart';

User userId = User(
  username: "joanna",
  email: "",
  uid: '',
);

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

class CommentBox extends StatelessWidget {
  final String comment;
  final Text timestamp;
  final num percentage;
  const CommentBox(
      {super.key,
      required this.comment,
      required this.timestamp,
      required this.percentage});

  @override
  Widget build(context) {
    return Container(
        padding: const EdgeInsets.all(10),
        width: 367,
        height: 116,
        color: Theme.of(context).colorScheme.primary,
        child: Stack(children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    backgroundColor: Theme.of(context).colorScheme.secondary,
                    radius: 15,
                    child: const Text('JC'),
                  ),
                  const SizedBox(width: 10),
                  Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${userId.username} is $percentage % through ${bookClub.currentBook}',
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                        timestamp,
                      ]),
                ],
              ),
              const SizedBox(height: 5),
              Text(comment, style: Theme.of(context).textTheme.bodySmall),
            ],
          ),
          Align(
              alignment: Alignment.bottomRight,
              child: Icon(
                Icons
                    .chat_bubble_outline_rounded, // need to change icon i dont like this one lol
                color: Theme.of(context).primaryIconTheme.color,
              )),
        ]));
  }
}
