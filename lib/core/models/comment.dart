import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:papyrus/core/models/book.dart';

class Comment {
  //change timestamp to actual timestamp instead of text
  final String comment;
  final String username;
  final Timestamp timestamp;
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
      'timestamp': timestamp,
      'percentage': percentage,
      'commentId': commentId,
      'likes': likes,
    };
  }

  static Comment fromMap(Map<String, dynamic> map, String commentId) {
    return Comment(
      comment: map['comment'],
      username: map['username'],
      timestamp: map['timestamp'] as Timestamp,
      percentage: map['percentage'],
      commentId: commentId,
      likes: List<String>.from(map['likes']),
    );
  }
}
