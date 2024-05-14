import 'package:flutter/material.dart';
import 'package:papyrus/core/models/book.dart';

class Comment {
  //change timestamp to actual timestamp instead of text
  final String comment;
  final String username;
  final Text timestamp;
  final num percentage;
  final String commentId;
  final List<String> likes;

  const Comment({
    required this.comment,
    required this.username,
    required this.timestamp,
    required this.percentage,
    required this.commentId,
    required this.likes,
  });

  Map<String, dynamic> toMap() {
    return {
      'comment': comment,
      'username': username,
      'timestamp': timestamp.data,
      'percentage': percentage,
      'commentId': commentId,
      'likes': likes,
    };
  }

  static Comment fromMap(Map<String, dynamic> map, Book currentBook) {
    return Comment(
      comment: map['comment'],
      username: map['username'],
      timestamp: Text(map['timestamp']),
      percentage: map['percentage'],
      commentId: map['commentId'],
      likes: List<String>.from(map['likes']),
    );
  }
}
