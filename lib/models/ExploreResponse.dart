import 'package:maana_main_project_2/models/FeedResponse.dart';

class ExploreResponse {
  List<Category> categories;

  ExploreResponse({this.categories});

  ExploreResponse.fromJson(Map<String, dynamic> json) {
    if (json['categories'] != null) {
      categories = new List<Category>();
      json['categories'].forEach((v) {
        categories.add(new Category.fromJson(v));
      });
    }
  }
}

class Category {
  String label;
  String url;
  List<Books> books;

  Category({this.label, this.books});

  Category.fromJson(Map<String, dynamic> json) {
    label = json['label'];
    url = json["url"];
    if (json['books'] != null) {
      books = new List<Books>();
      json['books'].forEach((v) {
        books.add(new Books.fromJson(v));
      });
    }
  }
}
