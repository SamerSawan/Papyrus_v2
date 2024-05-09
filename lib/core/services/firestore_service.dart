import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  final CollectionReference comments =
      FirebaseFirestore.instance.collection('comments');

  Future<void> addComment(String comment) {
    return comments.add({
      'comment': comment, 
      'timestamp': Timestamp.now(),
      });
  }


Stream<QuerySnapshot> getCommentsStream() {
  final commentsStream = comments.orderBy('timestamp', descending: true).snapshots();
  
  return commentsStream;

}
}