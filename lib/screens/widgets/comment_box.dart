import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:flutter/material.dart';
import 'package:papyrus/core/api/book_service.dart';
import 'package:papyrus/core/models/book.dart';
import 'package:papyrus/core/models/book_club.dart';
import 'package:papyrus/core/models/comment.dart';
import 'package:papyrus/screens/widgets/like_button.dart';

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

class CommentBox extends StatefulWidget {
  final Comment comment;
  final BookClub bookClub;

  const CommentBox({super.key, required this.comment, required this.bookClub});

  @override
  State<CommentBox> createState() => _CommentBoxState();
}

class _CommentBoxState extends State<CommentBox> {
  bool isLiked = false;
  BookService bookService = BookService();
  late Book book;
  final currentUser = auth.FirebaseAuth.instance.currentUser!;

  @override
  void initState() {
    super.initState();
    isLiked = widget.comment.likes.contains(currentUser.email);
    book = widget.bookClub.currentBook;
  }

  void toggleLike() {
    setState(() {
      isLiked = !isLiked;
    });

    DocumentReference commentRef = FirebaseFirestore.instance
        .collection('comments')
        .doc(widget.comment.commentId);

    if (isLiked) {
      commentRef.update({
        'Likes': FieldValue.arrayUnion([currentUser.email])
      });
    } else {
      commentRef.update({
        'Likes': FieldValue.arrayRemove([currentUser.email])
      });
    }
  }

  @override
  Widget build(context) {
    return Container(
        padding: const EdgeInsets.all(10),
        width: 367,
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
                          '${widget.comment.username} is ${widget.comment.percentage} % through ${book.title}',
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                        widget.comment.timestamp,
                      ]),
                ],
              ),
              const SizedBox(height: 5),
              Text(widget.comment.comment,
                  style: Theme.of(context).textTheme.bodySmall),
            ],
          ),
          Align(
            alignment: Alignment.bottomLeft,
            child: Icon(
              Icons.delete,
              color: Theme.of(context).primaryIconTheme.color,
              size: Theme.of(context).primaryIconTheme.size,
            ),
          ), // added delete icon
          Align(
              alignment: const Alignment(1, 1),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      LikeButton(
                          isLiked: isLiked, onTap: toggleLike), //like button
                      Text(
                        // number of likes
                        widget.comment.likes.length.toString(),
                        style: Theme.of(context).textTheme.bodySmall,
                      )
                    ],
                  ),
                  const SizedBox(width: 5),
                  Icon(
                    Icons
                        .chat_bubble_outline_rounded, // need to change comment icon i dont like this one lol
                    color: Theme.of(context).primaryIconTheme.color,
                    size: Theme.of(context).primaryIconTheme.size,
                  )
                ],
              )),
        ]));
  }
}
