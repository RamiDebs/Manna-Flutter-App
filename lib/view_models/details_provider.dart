import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:maana_main_project_2/models/FeedResponse.dart';
import 'package:maana_main_project_2/util/api.dart';

class DetailsProvider extends ChangeNotifier {
  bool loading = true;
  Books entry;

  Api api = Api();

  getFeed(String url) async {
    setLoading(true);
    try {
      // CategoryFeed feed = await api.getCategory(url);
      //  setRelated(feed);
      //   setLoading(false);
    } catch (e) {
      throw (e);
    }
  }

  void setLoading(value) {
    loading = value;
    notifyListeners();
  }

  void setEntry(value) {
    entry = value;
    notifyListeners();
  }
}
