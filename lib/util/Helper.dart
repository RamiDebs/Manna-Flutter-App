import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:lottie/lottie.dart';
import 'package:maana_main_project_2/components/common_signin.dart';

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
