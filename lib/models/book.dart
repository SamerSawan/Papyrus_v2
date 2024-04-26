class Book {
  final String title;
  final List<String> authors;
  final List<String> isbns;
  final String description;
  final int pageCount;
  final List<String> categories;
  final String image;

  Book({
    required this.title,
    required this.authors,
    required this.isbns,
    required this.description,
    required this.pageCount,
    required this.categories,
    required this.image,
  });

  factory Book.fromJson(Map<String, dynamic> json) {
    List<String> authors = List<String>.from(json['authors']);
    List<String> isbns = json['industryIdentifiers']
        .map<String>((isbn) => isbn['identifier'].toString())
        .toList();
    List<String> categories = List<String>.from(json['categories']);

    return Book(
      title: json['title'] ?? '',
      authors: authors,
      isbns: isbns,
      description: json['description'] ?? '',
      pageCount: json['pageCount'] ?? 0,
      categories: categories,
      image: json['imageLinks']['thumbnail'],
    );
  }
  @override
  String toString() {
    return 'Book(title: $title, authors: $authors, isbns: $isbns, '
        'description: $description, pageCount: $pageCount, categories: $categories, image: $image)';
  }
}
