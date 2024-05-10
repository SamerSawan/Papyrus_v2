import "package:papyrus/core/models/book.dart";
import "package:papyrus/core/models/user.dart";

class BookClub {
  final String name;
  final Book currentBook;
  final String description;
  final List<User> users;

  BookClub({
    required this.name,
    required this.currentBook,
    required this.description,
    required this.users,
  });

  int get numberOfUsers => users.length;

  @override
  String toString() {
    return 'BookClub(name: $name, currentBook: $currentBook, description: $description, users: $users)';
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'currentBook': currentBook.toMap(), // Convert currentBook to Map
      'description': description,
      'users': users
          .map((user) => user.toMap())
          .toList(), // Convert users to List<Map>
    };
  }

  factory BookClub.fromMap(Map<String, dynamic> map) {
    return BookClub(
      name: map['name'] ?? '',
      currentBook: Book.fromMap(map['currentBook'] ?? {}),
      description: map['description'] ?? '',
      users: (map['users'] as List<dynamic>? ?? [])
          .map((userMap) => User.fromMap(userMap))
          .toList(),
    );
  }
}
