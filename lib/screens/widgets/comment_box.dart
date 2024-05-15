import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:flutter/material.dart';
import 'package:papyrus/core/api/book_service.dart';
import 'package:papyrus/core/models/book.dart';
import 'package:papyrus/core/models/book_club.dart';
import 'package:papyrus/core/models/comment.dart';
import 'package:papyrus/screens/widgets/like_button.dart';

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

  final _numberToMonthMap = {
    1: "Jan",
    2: "Feb",
    3: "Mar",
    4: "Apr",
    5: "May",
    6: "Jun",
    7: "Jul",
    8: "Aug",
    9: "Sep",
    10: "Oct",
    11: "Nov",
    12: "Dec",
  };

  @override
  Widget build(context) {
    DateTime dateTime = widget.comment.timestamp.toDate();
    String formattedDate =
        "${dateTime.day} ${_numberToMonthMap[dateTime.month]} ${dateTime.year}";
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
                    child: Text(
                      widget.comment.username.substring(0, 1).toUpperCase(),
                      style: const TextStyle(
                          fontSize: 12, fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(width: 15),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              widget.comment.username,
                              style: Theme.of(context).textTheme.bodyLarge,
                            ),
                            const Spacer(),
                            const Icon(Icons.location_pin, size: 16),
                            Text('${widget.comment.percentage.round()}%',
                                style: Theme.of(context).textTheme.bodyLarge)
                          ],
                        ),
                        Text(formattedDate,
                            style: Theme.of(context).textTheme.bodySmall),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Text(
                widget.comment.comment,
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ],
          ), // added delete icon
          Align(
            alignment: const Alignment(1, 1),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    LikeButton(
                        isLiked: isLiked, onTap: toggleLike), //like button
                    //Text(
                    // number of likes
                    //widget.comment.likes.length.toString(),
                    //style: Theme.of(context).textTheme.bodySmall,
                    //)
                  ],
                ),
                const SizedBox(width: 5),
                Icon(
                  Icons
                      .chat_bubble_outline_rounded, // need to change comment icon i dont like this one lol
                  color: Theme.of(context).primaryIconTheme.color,
                  size: 22,
                )
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: Icon(
              Icons.delete,
              color: Theme.of(context).primaryIconTheme.color,
              size: 22,
            ),
          ),
        ]));
  }
}
