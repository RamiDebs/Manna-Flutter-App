class BookResponse {
  Book book;

  BookResponse({this.book});

  BookResponse.fromJson(Map<String, dynamic> json) {
    book = json['book'] != null ? new Book.fromJson(json['book']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.book != null) {
      data['book'] = this.book.toJson();
    }
    return data;
  }
}

class Book {
  String title;
  String content;
  String imageUrl;
  String website_url;
  String pdfUrl;
  List<Tags> tags;

  Book({this.title, this.content, this.imageUrl, this.pdfUrl, this.tags});

  Book.fromJson(Map<String, dynamic> json) {
    title = json['title']
        .toString()
        .replaceAll(r'&nbsp;', '')
        .replaceAll(r'&hellip;', '')
        .replaceAll('&#8211;', '-');
    content = json['content'];
    imageUrl = json['image_url'];
    website_url = json['website_url'];
    pdfUrl = json['pdf_url'];
    if (json['tags'] != null) {
      tags = new List<Tags>();
      json['tags'].forEach((v) {
        tags.add(new Tags.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['content'] = this.content;
    data['image_url'] = this.imageUrl;
    data['pdf_url'] = this.pdfUrl;
    if (this.tags != null) {
      data['tags'] = this.tags.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Tags {
  String name;
  String url;

  Tags({this.name, this.url});

  Tags.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['url'] = this.url;
    return data;
  }
}
