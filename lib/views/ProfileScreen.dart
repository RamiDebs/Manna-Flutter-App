import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lottie/lottie.dart';
import 'package:maana_main_project_2/util/api.dart';
import 'package:maana_main_project_2/util/shared_preferences_helper.dart';

class ProfileScreen extends StatefulWidget {
  final PageController pageController;
  final String userData;

  const ProfileScreen({Key key, this.pageController, this.userData})
      : super(key: key);

  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  var kMarginPadding = 16.0;
  var kFontSize = 13.0;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: ListView(
        // This next line does the trick.
        scrollDirection: Axis.vertical,
        children: <Widget>[
          new Container(
            padding: EdgeInsets.only(top: 50),
            color: Theme.of(context).primaryColor,
            child: Column(
              children: <Widget>[
                Padding(
                  padding:
                      EdgeInsets.only(top: 22, left: 22, bottom: 22, right: 22),
                  child: Lottie.asset(
                    'assets/user.json',
                    height: 200,
                    width: 200,
                    repeat: false,
                    reverse: true,
                    animate: true,
                  ),
                ),
                widget.userData != null
                    ? Center(
                        child: Container(
                          color: Theme.of(context).primaryColor,
                          child: Text(
                            widget.userData,
                            style: (TextStyle(
                                color: Theme.of(context).accentColor,
                                fontSize: 18)),
                          ),
                        ),
                      )
                    : Container(),
                Container(
                  margin: EdgeInsets.all(10),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    border: Border.all(
                        color: Color(0xffF8EBAA), // set border color
                        width: 3.0), // set border width
                    borderRadius: BorderRadius.all(
                        Radius.circular(10.0)), // set rounded corner radius
                  ),
                  child: FlatButton(
                      child: Text(
                        "تسجيل الخروج",
                        style: TextStyle(
                            color: Theme.of(context).accentColor, fontSize: 18),
                      ),
                      onPressed: () => _signOutButtonTapped()),
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.all(10),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              border: Border.all(
                  color: Color(0xffF8EBAA), // set border color
                  width: 3.0), // set border width
              borderRadius: BorderRadius.all(
                  Radius.circular(10.0)), // set rounded corner radius
            ),
            child: FlatButton(
                child: Text(
                  "إعادة تعيين كلمة المرور",
                  style: (TextStyle(
                      color: Theme.of(context).accentColor, fontSize: 18)),
                ),
                onPressed: () {
                  _displayDialog(context);
                }),
          ),
        ],
      ),
    );
  }

  TextEditingController _textFieldController = TextEditingController();

  _displayDialog(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(
              'اعد ضبط كلمه السر',
              textAlign: TextAlign.right,
            ),
            content: TextField(
              controller: _textFieldController,
              textInputAction: TextInputAction.go,
              keyboardType: TextInputType.emailAddress,
              textAlign: TextAlign.right,
              decoration: InputDecoration(
                  hintText: "أدخل بريدك الإلكتروني أو أسم المستخدم"),
            ),
            actions: <Widget>[
              new FlatButton(
                child: new Text('اعد ضبط'),
                onPressed: () {
                  Api()
                      .resetPassword(_textFieldController.text.trim())
                      .then((value) {
                    Navigator.of(context).pop();
                  });
                },
              )
            ],
          );
        });
  }

  _signOutButtonTapped() {
    AppLocalData().clearData().then((value) {
      widget.pageController.jumpToPage(2);
      Navigator.of(context).pop();
    });
  }
}
