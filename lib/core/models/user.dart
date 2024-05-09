import 'package:papyrus/core/models/book_club.dart';

class User {
  final String uid;
  final String username;
  final String email;
  final List<BookClub> bookClubs = [];

  User({required this.username, required this.email, required this.uid});

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'email': email,
      'username': username,
      'bookClubs': bookClubs
    };
  }
}
