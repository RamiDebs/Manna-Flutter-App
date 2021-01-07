import 'package:maana_main_project_2/models/Book.dart';

class Category {
  String label;
  List<Book> books;

  Category({this.label, this.books});

  Category.fromJson(Map<dynamic, dynamic> json) {
    if (json['label'] != null) {
      label = json['label'];
    }
    if (json['books'] != null) {
      books = new List<Book>();
      json['books'].forEach((v) {
        books.add(new Book.fromJson(v));
      });
    }
  }
}
