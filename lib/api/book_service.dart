import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:papyrus/models/book.dart';

class BookService {
  Future<Book?> searchBooks({required String bookTitle}) async {
    final response = await http.get(
      Uri.parse(
          "https://www.googleapis.com/books/v1/volumes?q=$bookTitle&key=AIzaSyAykfkx97pFdwyVvpzc5k0cECaFPXlia_A"),
      // headers: headers,
    );

    var body = response.body;
    var firstBookJson = jsonDecode(body)['items'][0]['volumeInfo'];
    return Book.fromJson(firstBookJson);
  }
}

void main() async {
  var bookService = BookService();
  var book = await bookService.searchBooks(bookTitle: "Anna Karenina");

  if (book != null) {
    print(book.image);
  } else {
    print("No book found");
  }
}
