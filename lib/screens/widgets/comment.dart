import 'package:flutter/material.dart';
import 'package:papyrus/core/models/user.dart';
import 'package:papyrus/core/models/book_club.dart';
import 'package:papyrus/theme/dark_mode.dart';


User userId = User(
  username: "joanna",
  email: "", 
  uid: '',
);

BookClub bookClub = BookClub(
  name: "shareholder pleasers",
  currentBook: "Anna Karenina",
  description: "Temporary Description",
  users: [],
);

class CommentBox extends StatelessWidget{
  final String comment;
  final Text timestamp;
  final num percentage;
  const CommentBox ({super.key, required this.comment, required this.timestamp, required this.percentage});
  
  @override
  Widget build(context) {
    return Container(
                padding: const EdgeInsets.all(10),
                width: 367,
                height: 116,
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
                                Icons.chat_bubble_outline_rounded, // need to change icon i dont like this one lol
                                color: Theme.of(context).primaryIconTheme.color,
                              )
                              ),
                ])
              );
  }
}