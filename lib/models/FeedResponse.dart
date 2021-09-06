class FeedResponse {
  List<Categories> categories;
  RecentBooks recentBooks;
  RecentBooks top;

  FeedResponse({this.categories, this.recentBooks, this.top});

  FeedResponse.fromJson(Map<String, dynamic> json) {
    if (json['categories'] != null) {
      categories = new List<Categories>();
      json['categories'].forEach((v) {
        categories.add(new Categories.fromJson(v));
      });
    }
    recentBooks = json['recent_books'] != null
        ? new RecentBooks.fromJson(json['recent_books'])
        : null;
    top = json['top'] != null ? new RecentBooks.fromJson(json['top']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.categories != null) {
      data['categories'] = this.categories.map((v) => v.toJson()).toList();
    }
    if (this.recentBooks != null) {
      data['recent_books'] = this.recentBooks.toJson();
    }
    if (this.top != null) {
      data['top'] = this.top.toJson();
    }
    return data;
  }
}

class Categories {
  String label;
  String url;

  Categories({this.label, this.url});

  Categories.fromJson(Map<String, dynamic> json) {
    label = json['label'];
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['label'] = this.label;
    data['url'] = this.url;
    return data;
  }
}

class RecentBooks {
  List<Books> books;

  RecentBooks({this.books});

  RecentBooks.fromJson(Map<String, dynamic> json) {
    if (json['books'] != null) {
      books = new List<Books>();
      json['books'].forEach((v) {
        books.add(new Books.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.books != null) {
      data['books'] = this.books.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Books {
  String title;
  String summary;
  String imageUrl;
  String pdfUrl;
  String url;
  String website_url;
  List<Tags> tags;

  Books(
      {this.title,
      this.summary,
      this.imageUrl,
      this.pdfUrl,
      this.url,
      this.tags});

  Books.fromJson(Map<String, dynamic> json) {
    title = json['title']
        .toString()
        .replaceAll(r'&nbsp;', '')
        .replaceAll(r'&hellip;', '')
        .replaceAll('&#8211;', '-');
    summary = json['summary']
        .toString()
        .replaceAll(r'&nbsp;', '')
        .replaceAll(r'&hellip;', '')
        .replaceAll('&#8211;', '-');
    imageUrl = json['image_url'];
    pdfUrl = json['pdf_url'];
    website_url = json['website_url'];
    url = json['url'];
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
    data['summary'] = this.summary;
    data['image_url'] = this.imageUrl;
    data['pdf_url'] = this.pdfUrl;
    data['url'] = this.url;
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
