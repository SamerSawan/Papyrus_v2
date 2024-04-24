import 'package:http/http.dart' as http;
import 'dart:convert';

class BookService {
  Future searchBooks({required String bookTitle}) async {
    final response = await http.get(
      Uri.parse(
          "https://www.googleapis.com/books/v1/volumes?q=$bookTitle&key=AIzaSyAykfkx97pFdwyVvpzc5k0cECaFPXlia_A"),
      // headers: headers,
    );

    var body = response.body;
    return body;
  }
}

void main() async {
  var bookService = BookService();
  await bookService.searchBooks(bookTitle: "Anna Karenina");
}
