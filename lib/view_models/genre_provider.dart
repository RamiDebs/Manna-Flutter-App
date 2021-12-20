import 'dart:async';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:maana_main_project_2/models/ExploreResponse.dart';
import 'package:maana_main_project_2/models/FeedResponse.dart';
import 'package:maana_main_project_2/util/api.dart';
import 'package:maana_main_project_2/util/enum/api_request_status.dart';
import 'package:maana_main_project_2/util/functions.dart';

class GenreProvider extends ChangeNotifier {
  ScrollController controller = ScrollController();
  List<Books> items = List();
  int page = 1;
  bool loadingMore = false;
  bool loadMore = true;
  APIRequestStatus apiRequestStatus = APIRequestStatus.loading;
  Api api = Api();

  getFeed(String url) async {
    setApiRequestStatus(APIRequestStatus.loading);
    print(url);
    try {
      Category category = await api.getSingleCategory(url);
      if (category.books != null) {
        if (category.books.length > 0) {
          items = category.books;
          setApiRequestStatus(APIRequestStatus.loaded);
          listener(url);
        }
      } else {
        setApiRequestStatus(APIRequestStatus.noData);
      }
    } catch (e) {
      checkError(e);
      throw (e);
    }
  }

  listener(url) {
    controller.addListener(() {
      if (controller.position.pixels == controller.position.maxScrollExtent) {
        if (!loadingMore) {
          paginate(url);
          // Animate to bottom of list
          Timer(Duration(milliseconds: 100), () {
            controller.animateTo(
              controller.position.maxScrollExtent,
              duration: Duration(milliseconds: 100),
              curve: Curves.easeIn,
            );
          });
        }
      }
    });
  }

  paginate(String url) async {
    if (apiRequestStatus != APIRequestStatus.loading &&
        !loadingMore &&
        loadMore) {
      Timer(Duration(milliseconds: 100), () {
        controller.jumpTo(controller.position.maxScrollExtent);
      });
      loadingMore = true;
      page = page + 1;
      notifyListeners();
      try {
        Category category = (await api.getSingleCategory(url + '&page=$page'));
        items.addAll(category.books);
        loadingMore = false;
        notifyListeners();
      } catch (e) {
        loadMore = false;
        loadingMore = false;
        notifyListeners();
        throw (e);
      }
    }
  }

  void checkError(e) {
    if (Functions.checkConnectionError(e)) {
      setApiRequestStatus(APIRequestStatus.connectionError);
      showToast('خطأ في الإتصال');
    } else {
      setApiRequestStatus(APIRequestStatus.error);
      showToast('حدث خطأ ما. أعد المحاولة من فضلك');
    }
  }

  showToast(msg) {
    Fluttertoast.showToast(
      msg: '$msg',
      toastLength: Toast.LENGTH_SHORT,
      timeInSecForIosWeb: 1,
    );
  }

  void setApiRequestStatus(APIRequestStatus value) {
    apiRequestStatus = value;
    notifyListeners();
  }
}
