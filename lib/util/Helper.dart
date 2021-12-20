import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:lottie/lottie.dart';
import 'package:maana_main_project_2/components/common_signin.dart';
import 'package:webview_flutter/webview_flutter.dart';

class Helper {
  static bool isTablet(context) {
    var shortestSide = MediaQuery.of(context).size.shortestSide;
    if (shortestSide < 600) {
      return false;
    } else {
      return true;
    }
  }

  static showToast(msg) {
    Fluttertoast.showToast(
      msg: '$msg',
      toastLength: Toast.LENGTH_LONG,
      timeInSecForIosWeb: 1,
    );
  }

  static void showErrorBottomSheet(BuildContext context, bool isTablet) {
    Widget widget;
    widget = ListView(
      children: [
        Lottie.asset('assets/books.json', repeat: false, height: 300),
        Padding(
          padding: EdgeInsets.only(bottom: 12),
          child: Center(
              child: Text(
            "يرجى الاشتراك في قسم كتب معنا الجديد",
            style: TextStyle(
              color: Theme.of(context).accentColor,
              fontSize: isTablet ? 30 : 20.0,
            ),
          )),
        ),
        Padding(
          padding: EdgeInsets.only(bottom: 12),
          child: Center(
              child: GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                    showBottomSheet(context, CommonSignIn(null, true, isTablet),
                        true, null);
                  },
                  child: Text(
                    "تسجيل الدخول",
                    style: TextStyle(
                      color: Theme.of(context).accentColor,
                      fontSize: isTablet ? 30 : 20.0,
                    ),
                  ))),
        ),
      ],
    );
    showModalBottomSheet(
        context: context,
        builder: (ctx) {
          return widget;
        });
  }

  static bool showSubscribeErrorBottomSheet(
      BuildContext context, bool isTablet) {
    Widget widget;
    widget = ListView(
      children: [
        Lottie.asset('assets/books.json', repeat: false, height: 300),
        Padding(
          padding: EdgeInsets.only(bottom: 12),
          child: Center(
              child: Text(
            "يرجى الاشتراك في قسم كتب معنا الجديد",
            style: TextStyle(
              color: Theme.of(context).accentColor,
              fontSize: isTablet ? 30 : 20.0,
            ),
          )),
        ),
        Padding(
          padding: EdgeInsets.only(bottom: 12),
          child: Center(
              child: GestureDetector(
                  onTap: () {
                    final Set<Factory> gestureRecognizers = [
                      Factory(() => EagerGestureRecognizer()),
                    ].toSet();
                    Navigator.pop(context);
                    showBottomSheet(
                        context,
                        WebView(
                          gestureRecognizers: gestureRecognizers,
                          initialUrl: 'https://newmana.staging-dev.com/shop',
                          javascriptMode: JavascriptMode.unrestricted,
                          onWebViewCreated:
                              (WebViewController webViewController) {},
                          javascriptChannels: <JavascriptChannel>[
                            JavascriptChannel(
                                name: 'Toaster',
                                onMessageReceived: (JavascriptMessage message) {
                                  // ignore: deprecated_member_use
                                  Scaffold.of(context).showSnackBar(
                                    SnackBar(content: Text(message.message)),
                                  );
                                })
                          ].toSet(),
                          navigationDelegate: (NavigationRequest request) {
                            print('allowing navigation to $request');
                            return NavigationDecision.navigate;
                          },
                          onPageStarted: (String url) {
                            print('Page started loading: $url');
                          },
                          onPageFinished: (String url) {
                            print('Page finished loading: $url');
                          },
                          gestureNavigationEnabled: false,
                        ),
                        false,
                        null);
                  },
                  child: Text(
                    "أشترك بمعنى",
                    style: TextStyle(
                      color: Theme.of(context).accentColor,
                      fontSize: isTablet ? 30 : 20.0,
                    ),
                  ))),
        ),
      ],
    );
    showModalBottomSheet(
        context: context,
        builder: (ctx) {
          return widget;
        });
  }

  static void showBottomSheet(BuildContext context, Widget widget,
      bool isScrollControlled, bool isLogedin) {
    showModalBottomSheet(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(25.0))),
        elevation: 2.0,
        backgroundColor: Theme.of(context).primaryColor,
        isScrollControlled: isScrollControlled ? isScrollControlled : true,
        isDismissible: true,
        context: context,
        builder: (ctx) {
          return widget;
        }).whenComplete(() {
      if (isLogedin != null) {
        isLogedin = true;
      }
    });
  }
}
