import "package:papyrus/core/models/user.dart";

class BookClub {
  final String name;
  final String currentBook;
  final String description;
  final List<User> users;

  BookClub({
    required this.name,
    required this.currentBook,
    required this.description,
    required this.users,
  });

  int get numberOfUsers => users.length;
}
