import 'package:flutter/material.dart';
import 'package:maana_main_project_2/models/FeedResponse.dart';
import 'package:maana_main_project_2/util/api.dart';
import 'package:maana_main_project_2/util/enum/api_request_status.dart';
import 'package:maana_main_project_2/util/functions.dart';

class HomeProvider with ChangeNotifier {
  FeedResponse feedResponse;
  List<Books> top = List();
  List<Books> recent = List();
  List<Categories> categories;
  APIRequestStatus apiRequestStatus = APIRequestStatus.loading;
  Api api = Api();

  getFeeds() async {
    setApiRequestStatus(APIRequestStatus.loading);
    try {
      feedResponse = await api.getFeed(Api.feed);
      if (feedResponse.top != null) {
        setTop(feedResponse.top.books);
      }
      if (feedResponse.recentBooks != null) {
        setRecent(feedResponse.recentBooks.books);
      }
      if (feedResponse.categories != null) {
        categories = feedResponse.categories;
      }
      setApiRequestStatus(APIRequestStatus.loaded);
    } catch (e) {
      debugPrint("error in HomeProvider " + e.toString());

      checkError(e);
    }
  }

  void checkError(e) {
    if (Functions.checkConnectionError(e)) {
      setApiRequestStatus(APIRequestStatus.connectionError);
    } else {
      setApiRequestStatus(APIRequestStatus.error);
    }
  }

  void setApiRequestStatus(APIRequestStatus value) {
    apiRequestStatus = value;
    notifyListeners();
  }

  void setTop(value) {
    top = value;
    notifyListeners();
  }

  void setRecent(value) {
    recent = value;
    notifyListeners();
  }
}
