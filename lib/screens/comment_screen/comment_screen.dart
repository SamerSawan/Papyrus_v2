import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:papyrus/core/api/firestore_service.dart';
import 'package:papyrus/core/api/book_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:papyrus/core/models/book.dart';
import 'package:papyrus/screens/widgets/comment.dart';
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
              List commentsList = snapshot.data!.docs;

              return ListView.builder(
                  itemExtent: 125,
                  itemCount: commentsList.length,
                  itemBuilder: (context, index) {
                    DocumentSnapshot document = commentsList[index];
                    String docId = document.id;

                    Map<String, dynamic> data =
                        document.data() as Map<String, dynamic>;
                    String commentText = data['comment'];
                    String usernameText = data['username'];
                    num percentageText = data['percentage'] == null
                        ? 0
                        : int.parse(data['percentage']);
                    Timestamp t = data['timestamp'] as Timestamp;
                    DateTime date = t.toDate();

                    return ListTile(
                      title: CommentBox(
                        book: widget.bookClub.currentBook,
                        commentId: docId,
                        username: usernameText,
                        percentage: percentageText,
                        comment: commentText,
                        likes: List<String>.from(document['likes'] ?? []),
                        timestamp: Text(
                            '${_numberToMonthMap[date.month]} ${date.day} ${date.year}',
                            style: Theme.of(context).textTheme.labelSmall,
                          )),
                    );
                  });
            } else {
              return const Text('No comments yet');
            }
          }),
    );
  }
}
