import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:papyrus/core/models/book.dart';

class BookService {
  Future<List<Book>> searchBooksByQuery(String query) async {
    List<Book> books = [];

    if (query.isEmpty) {
      return books;
    }

    final url =
        'https://www.googleapis.com/books/v1/volumes?q=$query&maxResults=10';
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = jsonDecode(response.body);
      final List<dynamic> items = responseData['items'];

      for (var item in items) {
        final Book book = Book.fromJson(item['volumeInfo']);
        books.add(book);
      }
    } else {
      throw Exception('Failed to load search results');
    }

    return books;
  }

  Future<Book> findBook({required String bookTitle}) async {
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
  var books = await bookService.searchBooksByQuery("The Blacktongue Thief");

  for (var book in books) {
    print(book);
  }
}
