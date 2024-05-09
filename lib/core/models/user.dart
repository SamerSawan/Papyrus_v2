import 'package:papyrus/core/models/book_club.dart';

class User {
  final String username;
  final String email;
  final List<BookClub> bookClubs = [];

  User({required this.username, required this.email});
}
