import 'package:flutter/cupertino.dart';
import 'package:maana_main_project_2/util/api.dart';

class ProfileProvider extends ChangeNotifier {
  Api api = Api();
  bool showLogin = false;

  setLogin(bool value) {
    showLogin = value;
    debugPrint("setLogin " + showLogin.toString());
    notifyListeners();
  }
}
