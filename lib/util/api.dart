import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:maana_main_project_2/models/ArticleResponse.dart';
import 'package:maana_main_project_2/models/ExploreResponse.dart';
import 'package:maana_main_project_2/models/FeedResponse.dart';
import 'package:maana_main_project_2/models/SingleArticleResponse.dart';
import 'package:maana_main_project_2/models/UserResponse.dart';
import 'package:maana_main_project_2/models/WordpressResponse.dart';

class Api {
  Dio dio = Dio();

  static String articles =
      "https//mana.domvp.xyz/wp-json/mana-flutter/v2/articles";
  static String explore =
      "https://mana.domvp.xyz/wp-json/mana-flutter/v2/explore";
  static String feed = "https://mana.domvp.xyz/wp-json/mana-flutter/v2/feed";
  static String auth = "https://mana.domvp.xyz/wp-json/jwt-auth/v1/token";
  static String validate =
      "https://mana.domvp.xyz/wp-json/jwt-auth/v1/token/validate";
  static String registerUserURL =
      "https://mana.domvp.xyz/wp-json/wp/v2/users/register";
  static String resetPasswordUrl =
      "https://mana.domvp.xyz/wp-json/wp/v2/users/lostpassword";

  Future<User> authtUser(String username, String password) async {
    Map<String, dynamic> payload = {"username": username, "password": password};
    // = {"username": username},{ "password": Password};
    var res = await dio.post(auth, data: payload).catchError((e) {
      debugPrint(e.toString());
      throw (e.toString());
    });
    User user;
    if (res.statusCode == 200) {
      debugPrint(res.data.toString());

      WordpressResponse wordpressResponse =
          WordpressResponse.fromJson(res.data);
      if (wordpressResponse.success) {
        user = new User(
            token: wordpressResponse.data.token,
            userDisplayName: wordpressResponse.data.displayName,
            userEmail: wordpressResponse.data.email,
            userNicename: wordpressResponse.data.nicename);
      } else {
        throw ('${wordpressResponse.message}');
      } // }
    } else {
      debugPrint("hereeeeeeeeeeeeeee");
      throw ('Error ${res.statusCode}');
    }
    dio.clear();
    return user;
  }

  Future<void> resetPassword(String email) async {
    dio.clear();
    await dio.post(
      resetPasswordUrl,
      data: {"user_login": "$email"},
    ).catchError((e) {
      debugPrint("hereeeeeeeeeeeeeee" + e.toString());

      throw (e);
    }).then((value) {
      return true;
    });
  }

  Future<ArticlesResponse> getArticles() async {
    var res = await dio.get(articles).catchError((e) {
      throw (e);
    });

    ArticlesResponse articleResponse;
    if (res.statusCode == 200) {
      articleResponse = ArticlesResponse.fromJson(res.data);
      debugPrint("json " + res.data.toString());
    } else {
      throw ('Error ${res.statusCode}');
    }
    dio.clear();
    return articleResponse;
  }

  Future<Article> getArticle(String url) async {
    var res = await dio.get(url);

    Article article;
    if (res.statusCode == 200) {
      article = SingleArticleResponse.fromJson(res.data).article;
      debugPrint("json " + res.data.toString());
    } else {
      throw ('Error ${res.statusCode}');
    }
    dio.clear();
    return article;
  }

  Future<FeedResponse> getFeed(
    String url,
  ) async {
    debugPrint("jsonn " + url);
    var res = await dio.get(url).catchError((e) {
      debugPrint("json error here");
      throw (e);
    });
    FeedResponse feedResponse;
    if (res.statusCode == 200) {
      feedResponse = FeedResponse.fromJson(res.data);
    } else {
      debugPrint("json " + res.statusCode.toString());

      throw ('Error ${res.statusCode}');
    }
    dio.clear();
    return feedResponse;
  }

  Future<Category> getSingleCategory(String url) async {
    var res = await dio.get(url).catchError((e) {
      throw (e);
    });
    Category category;
    if (res.statusCode == 200) {
      category = Category.fromJson(res.data);
      debugPrint("json " + json.toString());
    } else {
      throw ('Error ${res.statusCode}');
    }
    return category;
  }

  Future<ExploreResponse> getCategory(String url) async {
    var res = await dio.get(url).catchError((e) {
      throw (e);
    });
    ExploreResponse exploreResponse;
    if (res.statusCode == 200) {
      exploreResponse = ExploreResponse.fromJson(res.data);
      debugPrint("json " + res.data.toString());
    } else {
      throw ('Error ${res.statusCode}');
    }
    return exploreResponse;
  }

  Future<WordpressResponse> registerUser(
    String userName,
    String email,
    String password,
  ) async {
    var params = {"username": userName, "password": password, "email": email};
    WordpressResponse wordpressResponse;
    await dio
        .post(
      registerUserURL,
      options: Options(headers: {
        HttpHeaders.contentTypeHeader: "application/json",
      }),
      data: params,
    )
        .catchError((onError) {
      if (onError is DioError) {
        debugPrint("onError.response.data " + onError.response.data.toString());

        wordpressResponse = WordpressResponse.fromJson(onError.response.data);
        throw ('${wordpressResponse.message}');
      }
      debugPrint("Error1" + onError.toString());
      throw (onError);
    }).then((value) {
      if (value.statusCode == 200) {
        wordpressResponse = WordpressResponse.fromJson(value.data);
        if (wordpressResponse.code != 200) {
          debugPrint("Error3 ");

          throw ('Error ${wordpressResponse.message}');
        } else {
          //TODO registered
          return value;
        }
      } else {
        wordpressResponse = WordpressResponse.fromJson(value.data);
        debugPrint("Error2 ");

        throw ('${wordpressResponse.message}');
      }
    });

    return wordpressResponse;
  }
}
