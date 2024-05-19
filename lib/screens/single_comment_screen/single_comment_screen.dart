import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:papyrus/core/models/book_club.dart';
import 'package:papyrus/core/models/comment.dart';
import 'package:papyrus/screens/widgets/comment_box.dart';

class SingleCommentScreen extends StatelessWidget {
  final Comment comment;
  final String bookClubID;

  const SingleCommentScreen({
    Key? key,
    required this.comment,
    required this.bookClubID,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Comment Details'),
      ),
      body: FutureBuilder<DocumentSnapshot>(
        future: FirebaseFirestore.instance
            .collection('BookClubs')
            .doc(bookClubID)
            .get(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData) {
            return Center(child: Text('Book club not found'));
          } else {
            // Deserialize BookClub from the document snapshot
            final BookClub bookClub = BookClub.fromMap(
              snapshot.data!.data() as Map<String, dynamic>,
            );
            return SizedBox(
              height: 125,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: CommentBox(
                  comment: comment,
                  bookClub: bookClub,
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
