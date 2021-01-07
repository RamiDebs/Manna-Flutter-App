import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:maana_main_project_2/main_screen.dart';
import 'package:maana_main_project_2/util/Helper.dart';

class Splash extends StatefulWidget {
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  bool istablet = false;

  startTimeout() {
    return new Timer(Duration(seconds: 3), handleTimeout);
  }

  void handleTimeout() {
    changeScreen();
  }

  changeScreen() async {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (BuildContext context) {
          return MainScreen();
        },
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    startTimeout();
  }

  @override
  Widget build(BuildContext context) {
    istablet = Helper.isTablet(context);

    return Scaffold(
      backgroundColor: Color(0xff2B2825),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SvgPicture.asset(
              "assets/images/logo.svg",
              color: Color(0xffF8EBAA),
              height: istablet ? 300 : 200.0,
              width: istablet ? 300 : 200.0,
            ),
          ],
        ),
      ),
    );
  }
}
