import 'package:maana_main_project_2/models/ArticleResponse.dart';

class SingleArticleResponse {
  Article article;

  SingleArticleResponse({this.article});

  SingleArticleResponse.fromJson(Map<String, dynamic> json) {
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
