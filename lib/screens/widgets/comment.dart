import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:flutter/material.dart';
import 'package:papyrus/core/models/user.dart';
import 'package:papyrus/core/models/book_club.dart';
import 'package:papyrus/screens/widgets/like_button.dart';
import 'package:papyrus/core/api/firestore_service.dart';


BookClub bookClub = BookClub(
  name: "shareholder pleasers",
  currentBook: "Anna Karenina",
  description: "Temporary Description",
  users: [],
);

class CommentBox extends StatefulWidget{
  final String comment;
  final String username;
  final Text timestamp;
  final num percentage;
  final String commentId;
  final List<String> likes;

  const CommentBox ({
    super.key, 
    required this.comment, 
    required this.username,
    required this.timestamp, 
    required this.percentage,
    required this.commentId,
    required this.likes
    });

  @override
  State<CommentBox> createState() => _CommentBoxState();
}

class _CommentBoxState extends State<CommentBox> {

bool isLiked = false;
final currentUser = auth.FirebaseAuth.instance.currentUser!;

  @override
  void initState() {
    super.initState();
    isLiked = widget.likes.contains(currentUser.email); 
  }

  void toggleLike() {
    setState(() {
      isLiked = !isLiked;
    });

  DocumentReference commentRef =
    FirebaseFirestore.instance.collection('comments').doc(widget.commentId);

      if (isLiked){
        commentRef.update({
          'Likes' : FieldValue.arrayUnion([currentUser.email])
        });
      }
      else {
        commentRef.update({
         'Likes' : FieldValue.arrayRemove([currentUser.email])
        });
      }
  }

  @override
  Widget build(context) {
    return Container(
                padding: const EdgeInsets.all(10),
                width: 367,
                color: Theme.of(context).colorScheme.primary,
                child: Stack(
                  children: [Column(
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
                              '${widget.username} is ${widget.percentage} % through ${bookClub.currentBook}',
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                            widget.timestamp,
                        ]),
                        ],
                      ),
                      const SizedBox(height: 5),
                      Text(widget.comment, style: Theme.of(context).textTheme.bodySmall),
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
                        alignment: const Alignment(1,1),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                LikeButton(isLiked: isLiked, onTap: toggleLike), //like button
                                Text( // number of likes
                                  widget.likes.length.toString(),
                                  style: Theme.of(context).textTheme.bodySmall,
                                )
                              ],
                            ),
                            const SizedBox(width: 5),
                            Icon(
                              Icons.chat_bubble_outline_rounded, // need to change comment icon i dont like this one lol
                              color: Theme.of(context).primaryIconTheme.color,
                              size: Theme.of(context).primaryIconTheme.size,
                                )
                              ],
                            )
                          ),
                ])
              );
  }
}