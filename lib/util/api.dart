import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:maana_main_project_2/models/ArticleResponse.dart';
import 'package:maana_main_project_2/models/ExploreResponse.dart';
import 'package:maana_main_project_2/models/FeedResponse.dart';
import 'package:maana_main_project_2/models/SingleArticleResponse.dart';
import 'package:maana_main_project_2/models/UserProfile.dart';
import 'package:maana_main_project_2/models/UserResponse.dart';
import 'package:maana_main_project_2/models/WordpressResponse.dart';

class Api {
  Dio dio = Dio();
  static String baseURL = "https://mana.net/wp-json";
  static String manaFlutter = "$baseURL/mana-flutter/v2";
  static String articles = "$manaFlutter/articles";
  static String explore = "$manaFlutter/explore";
  static String feed = "$manaFlutter/feed";
  static String auth = "$baseURL/jwt-auth/v1/token";
  static String validate = "$baseURL/jwt-auth/v1/token/validate";
  static String registerUserURL = "$baseURL/wp/v2/users/register";
  static String resetPasswordUrl = "$baseURL/wp/v2/users/lost-password";

  static String profile = "$manaFlutter/profile";

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
      dio.options.headers['content-Type'] = 'application/json';

      articleResponse = ArticlesResponse.fromJson(res.data);
      debugPrint("json " + res.data.toString());
    } else {
      throw ('Error ${res.statusCode}');
    }
    dio.clear();
    return articleResponse;
  }

  Future<Article> getArticle(String url) async {
    dio.options.headers['content-Type'] = 'application/json';

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
    dio.options.headers['content-Type'] = 'application/json';

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
    dio.options.headers['content-Type'] = 'application/json';

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

  Future<UserProfile> getUserProfile(String token) async {
    dio.options.headers['content-Type'] = 'application/json';

    final response = await dio.get(profile,
        options: Options(headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        }));
    print('Token : ${token}');
    print(response);

    UserProfile userProfile;
    if (response.statusCode == 200) {
      userProfile = UserProfile.fromJson(response.data);
      debugPrint("json " + response.data.toString());
    } else {
      throw ('Error ${response.statusCode}');
    }
    return userProfile;
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
