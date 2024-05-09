import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  final CollectionReference comments =
      FirebaseFirestore.instance.collection('comments');
  final CollectionReference percentage =
      FirebaseFirestore.instance.collection('percentage');

  Future<void> addComment(String comment, num percentage) {
    return comments.add({
      'comment': comment, 
      'timestamp': Timestamp.now(),
      'percentage': percentage,
      });
  }


Stream<QuerySnapshot> getCommentsStream() {
  final commentsStream = comments.orderBy('timestamp', descending: true).snapshots();
  
  return commentsStream;

}
}