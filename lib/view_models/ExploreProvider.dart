import 'package:flutter/material.dart';
import 'package:maana_main_project_2/models/ExploreResponse.dart';
import 'package:maana_main_project_2/util/api.dart';
import 'package:maana_main_project_2/util/enum/api_request_status.dart';
import 'package:maana_main_project_2/util/functions.dart';

class ExploreProvider with ChangeNotifier {
  ExploreResponse exploreResponse = ExploreResponse();
  APIRequestStatus apiRequestStatus = APIRequestStatus.loading;
  Api api = Api();

  getExplore() async {
    setApiRequestStatus(APIRequestStatus.loading);

    try {
      api.getCategory(Api.explore).then((value) {
        exploreResponse = value;
        setApiRequestStatus(APIRequestStatus.loaded);
      });
    } catch (e) {
      debugPrint("error in getExplore " + e.toString());

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
}
