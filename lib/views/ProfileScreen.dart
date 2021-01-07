import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lottie/lottie.dart';
import 'package:maana_main_project_2/util/api.dart';
import 'package:maana_main_project_2/util/shared_preferences_helper.dart';

class ProfileScreen extends StatefulWidget {
  final PageController pageController;

  const ProfileScreen({Key key, this.pageController}) : super(key: key);

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
      body: SafeArea(
          top: true,
          child: Center(
            child: Column(
              children: <Widget>[
                new Container(
                  color: Theme.of(context).primaryColor,
                  height: 250.0,
                  child: Stack(
                    children: <Widget>[
                      Align(
                        alignment: Alignment.topRight,
                        child: FlatButton(
                            child: Text(
                              "تسجيل الخروج",
                              style: TextStyle(
                                  color: Theme.of(context).accentColor,
                                  fontSize: 18),
                            ),
                            onPressed: () => _signOutButtonTapped()),
                      ),
                      Padding(
                          padding: EdgeInsets.all(22),
                          child: Align(
                            alignment: Alignment.center,
                            child: Lottie.asset(
                              'assets/user.json',
                              repeat: false,
                              reverse: true,
                              animate: true,
                            ),
                          )),
                    ],
                  ),
                ),
                new Card(
                  color: Theme.of(context).primaryColor,

                  margin: EdgeInsets.all(10.0),
                  elevation: 5.0,
                  //color: Constants.lg_gray_light,
                  child: _profileItems(),
                ),
                Container(
                  color: Theme.of(context).primaryColor,
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: FlatButton(
                        child: Text(
                          "إعادة تعيين كلمة المرور",
                          style: (TextStyle(
                              color: Theme.of(context).accentColor,
                              fontSize: 18)),
                        ),
                        onPressed: () {
                          _displayDialog(context);
                        }),
                  ),
                ),
                new Card(
                  margin: EdgeInsets.all(10.0),
                  elevation: 5.0,
                  color: Theme.of(context).primaryColor,
                )
              ],
            ),
          )),
    );
  }

  Widget _profileItems() {
    return Column(
      children: <Widget>[],
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
