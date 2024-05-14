import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:papyrus/core/api/firestore_service.dart';
import 'package:papyrus/core/api/book_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:papyrus/core/models/comment.dart';
import 'package:papyrus/screens/widgets/comment_box.dart';
import 'package:papyrus/core/models/book_club.dart';

class CommentScreen extends StatefulWidget {
  BookClub bookClub;
  CommentScreen({super.key, required this.bookClub});

  @override
  State<StatefulWidget> createState() => _CommmentScreenState();
}

class _CommmentScreenState extends State<CommentScreen> {
  final FirestoreService firestoreService = FirestoreService();
  BookService bookService = BookService();

  @override
  Widget build(context) {
    return Scaffold(
      appBar: CupertinoNavigationBar(
        middle:
            Text('Comments', style: Theme.of(context).textTheme.titleMedium),
        leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios),
            onPressed: () => Navigator.of(context).pop()),
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
      ),
      body: StreamBuilder<QuerySnapshot>(
          stream: firestoreService.getCommentsStream(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              List<Comment> commentsList = snapshot.data!.docs
                  .map((doc) => Comment.fromMap(
                      doc.data()! as Map<String, dynamic>, doc.id))
                  .toList();

              return ListView.builder(
                  itemExtent: 125,
                  itemCount: commentsList.length,
                  itemBuilder: (context, index) {
                    Comment comment = commentsList[index];
                    return ListTile(
                      title: CommentBox(
                          comment: comment, bookClub: widget.bookClub),
                    );
                  });
            } else {
              return const Text('No comments yet');
            }
          }),
    );
  }
}
