class ArticlesResponse {
  List<Articles> articles;

  ArticlesResponse({this.articles});

  ArticlesResponse.fromJson(Map<String, dynamic> json) {
    if (json['articles'] != null) {
      articles = new List<Articles>();
      json['articles'].forEach((v) {
        articles.add(new Articles.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.articles != null) {
      data['articles'] = this.articles.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Articles {
  String title;
  String summary;
  String imageUrl;
  String url;

  Articles({this.title, this.summary, this.imageUrl, this.url});

  Articles.fromJson(Map<String, dynamic> json) {
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
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['summary'] = this.summary;
    data['image_url'] = this.imageUrl;
    data['url'] = this.url;
    return data;
  }
}

class SingleArticle {
  Article article;

  SingleArticle({this.article});

  SingleArticle.fromJson(Map<String, dynamic> json) {
    article =
        json['article'] != null ? new Article.fromJson(json['article']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.article != null) {
      data['article'] = this.article.toJson();
    }
    return data;
  }
}

class Article {
  String title;
  String content;
  String imageUrl;

  Article({this.title, this.content, this.imageUrl});

  Article.fromJson(Map<String, dynamic> json) {
    title = json['title']
        .toString()
        .replaceAll(r'&nbsp;', '')
        .replaceAll(r'&hellip;', '')
        .replaceAll('&#8211;', '-');
    content = json['content'];
    imageUrl = json['image_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['content'] = this.content;
    data['image_url'] = this.imageUrl;
    return data;
  }
}
