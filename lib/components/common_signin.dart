import 'package:email_validator/email_validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:maana_main_project_2/util/Helper.dart';
import 'package:maana_main_project_2/util/api.dart';
import 'package:maana_main_project_2/util/shared_preferences_helper.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

class CommonSignIn extends StatefulWidget {
  PageController pageController;
  bool login;
  bool showLogin;
  CommonSignIn(PageController pageController, bool login, bool showLogin) {
    this.pageController = pageController;
    this.login = login;
    this.showLogin = showLogin;
  }

  @override
  State<StatefulWidget> createState() {
    return _SignInUp(pageController, login, showLogin);
  }
}

class _SignInUp extends State<CommonSignIn> with AutomaticKeepAliveClientMixin {
  _SignInUp(PageController pageController, bool login, bool showLogin);
  bool isTablet = false;
  var divWidth;
  AppLocalData appLocalData = AppLocalData();
  bool switchToCreateAccount = false;
  final TextEditingController _emailTextController =
      new TextEditingController();
  final TextEditingController _passwordTextController =
      new TextEditingController();

  final TextEditingController _oldPasswordTextController =
      new TextEditingController();
  final TextEditingController _newPasswordTextController =
      new TextEditingController();
  final TextEditingController _confirmPasswordTextController =
      new TextEditingController();
  GlobalKey<FormState> _formKey1 = new GlobalKey<FormState>();
  GlobalKey<FormState> _formKey2;
  bool _form1Autovalidate = false;
  bool _form2Autovalidate = false;

  final TextEditingController _SignUpPasswordTextController =
      new TextEditingController();
  final TextEditingController _signUpUsernameTextController =
      new TextEditingController();

  final TextEditingController _signUpEmailTextController =
      new TextEditingController();
  final TextEditingController _ConfirmPasswordTextController =
      new TextEditingController();
  var kMarginPadding = 16.0;
  var kFontSize = 13.0;

  @override
  void initState() {
    super.initState();
    _formKey2 = new GlobalKey<FormState>();

    if (!widget.login) {
      switchToCreateAccount = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    isTablet = Helper.isTablet(context);
    super.build(context);
    return switchToCreateAccount
        ? Form(key: _formKey2, child: buildEmailSignUpForm())
        : Form(
            key: _formKey1,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                new Container(
                  margin: EdgeInsets.only(top: 75.0, left: 15.0, right: 15.0),
                  child: new Text(
                    "تسجيل الدخول",
                    maxLines: 1,
                    style: TextStyle(fontSize: isTablet ? 27 : 18),
                  ),
                ),
                new Directionality(
                    textDirection: TextDirection.rtl,
                    child: Container(
                      padding: EdgeInsets.only(left: 10.0, right: 10.0),
                      margin: EdgeInsets.only(
                          left: kMarginPadding, right: kMarginPadding),
                      child: new TextFormField(
                          controller: _emailTextController,
                          validator: _validateFields,
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                              labelText: "اسم المستخدم*",
                              hintText: "أدخل اسم المستخدم الخاص بك",
                              labelStyle:
                                  new TextStyle(fontSize: isTablet ? 27 : 18))),
                    )),
                SizedBox(
                  height: 10.0,
                ),
                new Directionality(
                    textDirection: TextDirection.rtl,
                    child: Container(
                      padding: EdgeInsets.only(left: 10.0, right: 10.0),
                      margin: EdgeInsets.only(
                          left: kMarginPadding, right: kMarginPadding),
                      child: new TextFormField(
                          style: new TextStyle(
                              fontSize: isTablet ? 27 : 18,
                              color: Colors.black38),
                          obscureText: true,
                          validator: (String value) {
                            if (value.isEmpty) {
                              return "من فضلك أدخل كلمة السر";
                            } else {
                              return null;
                            }
                          },
                          controller: _passwordTextController,
                          decoration: InputDecoration(
                              labelText: "كلمة السر*",
                              hintText: "أدخل كلمة السر",
                              labelStyle:
                                  new TextStyle(fontSize: isTablet ? 27 : 18))),
                    )),
                SizedBox(
                  height: 10.0,
                ),
                new RoundedLoadingButton(
                  color: Theme.of(context).accentColor,
                  controller: _btnController,
                  onPressed: () => _loginButtonTapped(),
                  child: new Text(
                    "تسجيل الدخول",
                    style: TextStyle(
                        fontSize: isTablet ? 27 : 18,
                        color: Theme.of(context).scaffoldBackgroundColor),
                  ),
                ),
                new FlatButton(
                    onPressed: () {
                      _displayDialog(context);
                    },
                    child: new Text(
                      'هل نسيت كلمة المرور؟',
                      style: TextStyle(fontSize: isTablet ? 27 : 18),
                    )),
                new FlatButton(
                    onPressed: () {
                      setState(() {
                        switchToCreateAccount = true;
                      });
                    },
                    child: new Text(
                      'انشاء حساب جديد',
                      style: TextStyle(fontSize: isTablet ? 27 : 18),
                    )),
              ],
            ));
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
  final RoundedLoadingButtonController _btnController =
      new RoundedLoadingButtonController();
  final RoundedLoadingButtonController _signUpBtnController =
      new RoundedLoadingButtonController();
  _loginButtonTapped() {
    debugPrint("_loginButtonTapped");
    FocusScope.of(context).requestFocus(new FocusNode());
    if (_formKey1.currentState.validate()) {
      if (_emailTextController.text.length > 0&&
          _passwordTextController.text.length > 0) {
        Api()
            .authtUser(_emailTextController.text.toString(),
                _passwordTextController.text.toString())
            .then((value) {
          appLocalData.setName(value.userNicename);
          appLocalData.setVIP(value.isVipMember);
          appLocalData.setEmail(value.userEmail);
          appLocalData.setToken(value.token);
          appLocalData.setIsUserLoggedIn(true);
          debugPrint("getIsUserLoggedIn " +
              appLocalData.getIsUserLoggedIn().toString());
          setState(() {
            widget.showLogin = true;
            if (widget.pageController != null) {
              widget.pageController.jumpToPage(2);
            }
            Navigator.pop(context);
          });
        }).catchError((onError) {
          Helper.showToast(onError);
          debugPrint(onError.toString());
          _btnController.reset();
        });
      } else {
        Helper.showToast('معلومات غير صحيحة');

        _btnController.reset();
      }
    } else {
      _btnController.reset();
    }
  }

  String _validateFields(String text) {
    if (text.length == 0) {
      return "لا يجب أن تكون فارغة";
    } else {
      return null;
    }
  }

  Widget buildEmailSignUpForm() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        new Container(
          margin: EdgeInsets.only(top: 75.0, left: 15.0, right: 15.0),
          child: new Text(
            'انشاء حساب جديد',
            maxLines: 1,
            style: TextStyle(fontSize: isTablet ? 27 : 18),
          ),
        ),
        new Directionality(
            textDirection: TextDirection.rtl,
            child: Container(
              padding: EdgeInsets.only(left: 10.0, right: 10.0),
              margin:
                  EdgeInsets.only(left: kMarginPadding, right: kMarginPadding),
              child: new TextFormField(
                  controller: _signUpUsernameTextController,
                  validator: _validateFields,
                  autovalidate: _form2Autovalidate,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                      labelText: "اسم المستخدم*",
                      hintText: "أدخل اسم المستخدم الخاص بك",
                      labelStyle: new TextStyle(fontSize: isTablet ? 27 : 18))),
            )),
        SizedBox(
          height: 10.0,
        ),
        new Directionality(
            textDirection: TextDirection.rtl,
            child: Container(
              padding: EdgeInsets.only(left: 10.0, right: 10.0),
              margin:
                  EdgeInsets.only(left: kMarginPadding, right: kMarginPadding),
              child: new TextFormField(
                  controller: _signUpEmailTextController,
                  validator: _validateFields,
                  autovalidate: _form2Autovalidate,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                      labelText: "البريد الالكتروني*",
                      hintText: "أدخل البريد الالكتروني الخاص بك",
                      labelStyle: new TextStyle(fontSize: isTablet ? 27 : 18))),
            )),
        SizedBox(
          height: 10.0,
        ),
        new Directionality(
            textDirection: TextDirection.rtl,
            child: Container(
              padding: EdgeInsets.only(left: 10.0, right: 10.0),
              margin:
                  EdgeInsets.only(left: kMarginPadding, right: kMarginPadding),
              child: new TextFormField(
                  style: new TextStyle(
                      fontSize: isTablet ? 27 : 18, color: Colors.black38),
                  obscureText: true,
                  validator: (String value) {
                    if (value.isEmpty) {
                      return "من فضلك أدخل كلمة السر";
                    } else {
                      return null;
                    }
                  },
                  controller: _SignUpPasswordTextController,
                  decoration: InputDecoration(
                      labelText: "كلمة السر*",
                      hintText: "أدخل كلمة السر",
                      labelStyle: new TextStyle(fontSize: isTablet ? 27 : 18))),
            )),
        SizedBox(
          height: 10.0,
        ),
        new Directionality(
            textDirection: TextDirection.rtl,
            child: Container(
              padding: EdgeInsets.only(left: 10.0, right: 10.0),
              margin:
                  EdgeInsets.only(left: kMarginPadding, right: kMarginPadding),
              child: new TextFormField(
                  style: new TextStyle(
                      fontSize: isTablet ? 27 : 18, color: Colors.black38),
                  obscureText: true,
                  validator: (String value) {
                    if (value.isEmpty) {
                      return "من فضلك أدخل كلمة السر";
                    } else {
                      return null;
                    }
                  },
                  autovalidate: _form2Autovalidate,
                  controller: _ConfirmPasswordTextController,
                  decoration: InputDecoration(
                      labelText: "تأكيد كلمة السر*",
                      hintText: "أدخل كلمة السر مرة أخرى",
                      labelStyle: new TextStyle(fontSize: isTablet ? 27 : 18))),
            )),
        SizedBox(
          height: 10.0,
        ),
        new RoundedLoadingButton(
          color: Theme.of(context).accentColor,
          controller: _signUpBtnController,
          onPressed: () => _signUpButtonTaped(),
          child: new Text(
            "انشئ حساب",
            style: TextStyle(
                fontSize: isTablet ? 27 : 18,
                color: Theme.of(context).scaffoldBackgroundColor),
          ),
        ),
        new FlatButton(
            onPressed: () {
              setState(() {
                switchToCreateAccount = false;
              });
            },
            child: new Text(
              'تسجيل الدخول',
              style: TextStyle(fontSize: isTablet ? 27 : 18),
            )),
      ],
    );

    // return Column(
    //   mainAxisAlignment: MainAxisAlignment.start,
    //   crossAxisAlignment: CrossAxisAlignment.center,
    //   mainAxisSize: MainAxisSize.max,
    //   children: <Widget>[
    //     new Container(
    //       margin: EdgeInsets.only(top: 75.0, left: 15.0, right: 15.0),
    //       child: new Text(
    //         "تسجيل الدخول",
    //         maxLines: 1,
    //         style: TextStyle(fontSize: isTablet ? 27 : 18),
    //       ),
    //     ),
    //     new Directionality(
    //         textDirection: TextDirection.rtl,
    //         child: Container(
    //           padding: EdgeInsets.only(left: 10.0, right: 10.0),
    //           margin:
    //               EdgeInsets.only(left: kMarginPadding, right: kMarginPadding),
    //           child: new TextFormField(
    //               controller: _emailTextController,
    //               validator: _validateFields,
    //               autovalidate: _form2Autovalidate,
    //               keyboardType: TextInputType.emailAddress,
    //               decoration: InputDecoration(
    //                 labelText: "اسم المستخدم*",
    //                 hintText: "أدخل اسم المستخدم الخاص بك",
    //                 labelStyle: TextStyle(fontSize: isTablet ? 27 : 18),
    //               )),
    //         )),
    //     new Directionality(
    //         textDirection: TextDirection.rtl,
    //         child: Container(
    //           padding: EdgeInsets.only(left: 10.0, right: 10.0),
    //           margin:
    //               EdgeInsets.only(left: kMarginPadding, right: kMarginPadding),
    //           child: new TextFormField(
    //               controller: _emailTextController,
    //               validator: _validateFields,
    //               autovalidate: _form2Autovalidate,
    //               keyboardType: TextInputType.emailAddress,
    //               decoration: InputDecoration(
    //                   labelText: "البريد الالكتروني*",
    //                   hintText: "أدخل البريد الالكتروني الخاص بك",
    //                   labelStyle: new TextStyle(fontSize: isTablet ? 23 : 13))),
    //         )),
    //     SizedBox(
    //       height: 10.0,
    //     ),
    //     new Directionality(
    //         textDirection: TextDirection.rtl,
    //         child: Container(
    //           padding: EdgeInsets.only(left: 10.0, right: 10.0),
    //           margin:
    //               EdgeInsets.only(left: kMarginPadding, right: kMarginPadding),
    //           child: new TextFormField(
    //               style: new TextStyle(
    //                   fontSize: isTablet ? 27 : 18, color: Colors.black38),
    //               obscureText: true,
    //               autovalidate: _form2Autovalidate,
    //               validator: (String value) {
    //                 if (value.isEmpty) {
    //                   return "من فضلك أدخل كلمة السر";
    //                 } else {
    //                   return null;
    //                 }
    //               },
    //               controller: _passwordTextController,
    //               decoration: InputDecoration(
    //                 labelText: "كلمة السر*",
    //                 hintText: "أدخل كلمة السر",
    //                 labelStyle: TextStyle(fontSize: isTablet ? 27 : 18),
    //               )),
    //         )),
    //     new Directionality(
    //         textDirection: TextDirection.rtl,
    //         child: Container(
    //           padding: EdgeInsets.only(left: 10.0, right: 10.0),
    //           margin:
    //               EdgeInsets.only(left: kMarginPadding, right: kMarginPadding),
    //           child: new TextFormField(
    //               style: new TextStyle(
    //                   fontSize: isTablet ? 27 : 18, color: Colors.black38),
    //               obscureText: true,
    //               validator: (String value) {
    //                 if (value.isEmpty) {
    //                   return "من فضلك أدخل كلمة السر";
    //                 } else {
    //                   return null;
    //                 }
    //               },
    //               controller: _passwordTextController,
    //               decoration: InputDecoration(
    //                   labelText: "تأكيد كلمة السر*",
    //                   hintText: "أدخل كلمة السر مرة أخرى",
    //                   labelStyle: new TextStyle(fontSize: isTablet ? 27 : 18))),
    //         )),
    //     SizedBox(
    //       height: 10.0,
    //     ),
    //     new RoundedLoadingButton(
    //       onPressed: _signUpButtonTaped(),
    //       color: Theme.of(context).accentColor,
    //       controller: _signUpBtnController,
    //       child: new Text(
    //         "انشئ حساب",
    //         style: TextStyle(
    //             color: Theme.of(context).scaffoldBackgroundColor,
    //             fontSize: isTablet ? 27 : 18),
    //       ),
    //     ),
    //     new FlatButton(
    //         onPressed: () {
    //           setState(() {
    //             switchToCreateAccount = false;
    //           });
    //         },
    //         child: new Text(
    //           'تسجيل الدخول',
    //           style: TextStyle(fontSize: isTablet ? 27 : 18),
    //         )),
    //   ],
    // );
  }

  _signUpButtonTaped() {
    FocusScope.of(context).requestFocus(new FocusNode());
    if (_formKey2.currentState.validate()) {
      if (EmailValidator.validate(_signUpEmailTextController.text.trim()) &&
          _SignUpPasswordTextController.text.toString() ==
              _confirmPasswordTextController.text.toString()) {
        Api()
            .registerUser(
                _signUpUsernameTextController.text,
                _signUpEmailTextController.text,
                _SignUpPasswordTextController.text)
            .then((value) {
          setState(() {
            switchToCreateAccount = false;
          });
        }).catchError((onError) {
          debugPrint("showloginSheet " + onError.toString());
          Helper.showToast(onError);
          _signUpBtnController.error();
          _signUpBtnController.reset();
        });
      } else {
        Helper.showToast('معلومات غير صحيحة');
        _signUpBtnController.reset();
      }
    } else {
      _signUpBtnController.error();
      _signUpBtnController.reset();
    }
  }

  @override
  bool get wantKeepAlive => true;
}
