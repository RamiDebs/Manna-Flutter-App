import 'package:shared_preferences/shared_preferences.dart';

class AppLocalData {
  Future<SharedPreferences> _prefs;
  bool isUserLoggedIn = false;
  bool isVIP = false;
  String Token = "";
  String name = "";
  String email = "";

  AppLocalData() {
    if (_prefs == null) {
      _prefs = SharedPreferences.getInstance();
    }

    _prefs.then((value) {
      setIsUserLoggedIn(value.getBool("loggedIn") ?? false);
      setToken(value.getString("token") ?? "");
      setEmail(value.getString("email") ?? "");
      setName(value.getString("name") ?? "");
      setVIP(value.getBool("vip") ?? false);
    });
  }
  String getToken() {
    return Token;
  }

  void setToken(value) {
    _prefs.then((sharedPreferences) {
      sharedPreferences.setString("token", value != null ? value : "");
    });

    Token = value;
  }

  Future<bool> getIsUserLoggedIn() async {
    await _prefs.then((sharedPreferences) {
      isUserLoggedIn = sharedPreferences.getBool("loggedIn");
    });
    return isUserLoggedIn;
  }

  void setIsUserLoggedIn(value) {
    _prefs.then((sharedPreferences) {
      sharedPreferences.setBool("loggedIn", value != null ? value : false);
    });

    isUserLoggedIn = value;
  }

  void setEmail(value) {
    _prefs.then((sharedPreferences) {
      sharedPreferences.setString("email", value != null ? value : "");
    });

    email = value;
  }

  String getEmail() {
    return email;
  }

  void setName(value) {
    _prefs.then((sharedPreferences) {
      sharedPreferences.setString("name", value != null ? value : "");
    });
    name = value;
  }

  String getName() {
    return name;
  }

  void setVIP(value) {
    _prefs.then((sharedPreferences) {
      sharedPreferences.setBool("vip", value != null ? value : false);
      isVIP = value;
    });
  }

  bool getVIP() {
    return isVIP;
  }

  Future<void> clearData() async {
    _prefs.then((value) {
      setIsUserLoggedIn(false);
      setToken("");
      setEmail("");
      setName("");
      setVIP(false);
    });
  }
}
