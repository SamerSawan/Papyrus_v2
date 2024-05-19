import "package:papyrus/core/models/book.dart";
import "package:papyrus/core/models/comment.dart";
import "package:papyrus/core/models/user.dart";

class BookClub {
  final String name;
  final Book currentBook;
  final String description;
  final List<User> users;
  final List<Comment> comments;
  final Map<String, num>
      userProgressMap; // Changed from User to String for the key

  BookClub({
    required this.name,
    required this.currentBook,
    required this.description,
    required this.users,
    required this.comments,
    required this.userProgressMap,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'currentBook': currentBook.toMap(),
      'description': description,
      'users': users.map((user) => user.toMap()).toList(),
      'comments': comments.map((comment) => comment.toMap()).toList(),
      'userProgressMap': userProgressMap,
    };
  }

  factory BookClub.fromMap(Map<String, dynamic> map) {
    return BookClub(
      name: map['name'] ?? '',
      currentBook: Book.fromMap(map['currentBook'] ?? {}),
      description: map['description'] ?? '',
      users: (map['users'] as List<dynamic>? ?? [])
          .map((userMap) => User.fromMap(userMap as Map<String, dynamic>))
          .toList(),
      comments: (map['comments'] as List<dynamic>? ?? []).map((commentMap) {
        final commentId = commentMap['commentId'] as String;
        return Comment.fromMap(commentMap as Map<String, dynamic>, commentId);
      }).toList(),
      userProgressMap: (map['userProgressMap'] as Map<String, dynamic>? ?? {})
          .map((username, progress) => MapEntry(username, progress)),
    );
  }
}
