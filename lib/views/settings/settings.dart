import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:maana_main_project_2/components/common_signin.dart';
import 'package:maana_main_project_2/theme/theme_config.dart';
import 'package:maana_main_project_2/util/Helper.dart';
import 'package:maana_main_project_2/util/api.dart';
import 'package:maana_main_project_2/util/router.dart';
import 'package:maana_main_project_2/util/shared_preferences_helper.dart';
import 'package:maana_main_project_2/view_models/app_provider.dart';
import 'package:maana_main_project_2/views/ProfileScreen.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:webview_flutter/webview_flutter.dart';

class Profile extends StatefulWidget {
  PageController pageController;
  Profile(PageController pageController) {
    this.pageController = pageController;
  }

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> with AutomaticKeepAliveClientMixin {
  List items;
  List mainItems;
  List myAccount;
  bool showLogin = false;
  var divWidth;
  bool istablet = false;
  bool isLoading = true;
  String userData = null;

  var kMarginPadding = 16.0;
  var kFontSize = 13.0;
  AppLocalData appLocalData;

  @override
  void initState() {
    super.initState();

    items = [];
    mainItems = [];
    myAccount = [];

    myAccount.add({
      'icon': Feather.user,
      'title': 'حسابي',
      'function': () => Helper.showBottomSheet(
          context,
          ProfileScreen(
            pageController: widget.pageController,
            userData: userData,
          ),
          false,
          null),
    });

    mainItems.addAll([
      {
        'icon': Icons.supervised_user_circle,
        'title': ' إنشاء حساب جديد؟',
        'function': () => showCreateAccountSheet(),
      },
      {
        'icon': Feather.user,
        'title': 'تسجيل الدخول',
        'function': () => showloginSheet(),
      },
    ]);

    items.addAll([
      {
        'icon': Feather.moon,
        'title': 'الوضع المظلم',
        'function': () => _pushPage(_buildThemeSwitch(items[2])),
      },
      {
        'icon': Feather.info,
        'title': 'عن معنى',
        'function': () => showAbout(),
      },
      {
        'icon': Feather.file_text,
        'title': 'حقوق النشر و التراخيص',
        'function': () => showAbout(),
      },
    ]);
    if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();

    var appLocalData = AppLocalData();
    appLocalData.getIsUserLoggedIn().then((value) {
      if (value != null) {
        showLogin = value ?? false;
        if (showLogin) {
          Api().getUserProfile(appLocalData.getToken()).then((userProfile) {
            debugPrint("userProfile.user.isVipMember " +
                userProfile.user.isVipMember.toString());
            appLocalData.setVIP(userProfile.user.isVipMember);
            if (!userProfile.user.isVipMember) {
              myAccount.add({
                'icon': Feather.credit_card,
                'title': 'أشتراك معنى',
                'function': () => showPayment(),
              });
            } else {
              userData =
                  " أنت مشرتك بمنصة معنى الثقافية\n(${userProfile.user.memberships.first.plan.name})";
            }

            setState(() {
              isLoading = false;
            });
          }).catchError((onError) {
            debugPrint(onError.toString());
            setState(() {
              isLoading = false;
            });
          });
        }
      } else {
        setState(() {
          showLogin = false;
          isLoading = false;
        });
      }
    });
    if (!showLogin) {
      setState(() {
        showLogin = false;
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    istablet = Helper.isTablet(context);
    if (MediaQuery.of(context).platformBrightness == Brightness.dark) {
      items.removeWhere((item) => item['title'] == 'الوضع المظلم');
    }
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            'حسابي',
            style: TextStyle(
              fontSize: istablet ? 30 : 20.0,
            ),
          ),
        ),
        body: isLoading
            ? SizedBox(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child: Shimmer.fromColors(
                    baseColor: Color(0xFFEAEAEA),
                    highlightColor: Color(0xFFcfd8dc),
                    direction: ShimmerDirection.rtl,
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: <Widget>[
                          Padding(
                              padding: EdgeInsets.only(bottom: 22),
                              child: Container(
                                  width: istablet ? 350 : 250,
                                  height: istablet ? 42 : 32,
                                  decoration: new BoxDecoration(
                                      color: Colors.black,
                                      borderRadius: new BorderRadius.only(
                                        topLeft: const Radius.circular(25.0),
                                        topRight: const Radius.circular(25.0),
                                        bottomLeft: const Radius.circular(25.0),
                                        bottomRight:
                                            const Radius.circular(25.0),
                                      )))),
                          Padding(
                              padding: EdgeInsets.only(bottom: 22),
                              child: Container(
                                  width: istablet ? 350 : 250,
                                  height: istablet ? 42 : 32,
                                  decoration: new BoxDecoration(
                                      color: Colors.black,
                                      borderRadius: new BorderRadius.only(
                                        topLeft: const Radius.circular(25.0),
                                        topRight: const Radius.circular(25.0),
                                        bottomLeft: const Radius.circular(25.0),
                                        bottomRight:
                                            const Radius.circular(25.0),
                                      )))),
                          Padding(
                              padding: EdgeInsets.only(bottom: 22),
                              child: Container(
                                  width: istablet ? 350 : 250,
                                  height: istablet ? 42 : 32,
                                  decoration: new BoxDecoration(
                                      color: Colors.black,
                                      borderRadius: new BorderRadius.only(
                                        topLeft: const Radius.circular(25.0),
                                        topRight: const Radius.circular(25.0),
                                        bottomLeft: const Radius.circular(25.0),
                                        bottomRight:
                                            const Radius.circular(25.0),
                                      )))),
                          Padding(
                              padding: EdgeInsets.only(bottom: 22),
                              child: Container(
                                  width: istablet ? 350 : 250,
                                  height: istablet ? 42 : 32,
                                  decoration: new BoxDecoration(
                                      color: Colors.black,
                                      borderRadius: new BorderRadius.only(
                                        topLeft: const Radius.circular(25.0),
                                        topRight: const Radius.circular(25.0),
                                        bottomLeft: const Radius.circular(25.0),
                                        bottomRight:
                                            const Radius.circular(25.0),
                                      )))),
                          Padding(
                              padding: EdgeInsets.only(bottom: 22),
                              child: Container(
                                  width: istablet ? 350 : 250,
                                  height: istablet ? 42 : 32,
                                  decoration: new BoxDecoration(
                                      color: Colors.black,
                                      borderRadius: new BorderRadius.only(
                                        topLeft: const Radius.circular(25.0),
                                        topRight: const Radius.circular(25.0),
                                        bottomLeft: const Radius.circular(25.0),
                                        bottomRight:
                                            const Radius.circular(25.0),
                                      )))),
                          Container(
                              width: istablet ? 350 : 250,
                              height: istablet ? 42 : 32,
                              decoration: new BoxDecoration(
                                  color: Colors.black,
                                  borderRadius: new BorderRadius.only(
                                    topLeft: const Radius.circular(25.0),
                                    topRight: const Radius.circular(25.0),
                                    bottomLeft: const Radius.circular(25.0),
                                    bottomRight: const Radius.circular(25.0),
                                  )))
                        ],
                      ),
                    )),
              )
            : SingleChildScrollView(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                    showLogin
                        ? ListView.separated(
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: myAccount.length,
                            itemBuilder: (BuildContext context, int index) {
                              return GestureDetector(
                                  onTap: myAccount[index]['function'],
                                  child: Padding(
                                      padding: EdgeInsets.all(8),
                                      child: Container(
                                          width:
                                              MediaQuery.of(context).size.width,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Padding(
                                                  padding: EdgeInsets.only(
                                                      right: 10, left: 8),
                                                  child: Text(
                                                    myAccount[index]['title'],
                                                    textAlign: TextAlign.end,
                                                    style: TextStyle(
                                                        fontSize:
                                                            istablet ? 27 : 18),
                                                  )),
                                              Icon(
                                                myAccount[index]['icon'],
                                                size: istablet ? 38 : 28,
                                              ),
                                            ],
                                          ))));
                            },
                            separatorBuilder:
                                (BuildContext context, int index) {
                              return Divider();
                            },
                          )
                        : Directionality(
                            textDirection: TextDirection.rtl,
                            child: ListView.separated(
                              shrinkWrap: true,
                              padding: EdgeInsets.symmetric(horizontal: 10),
                              physics: NeverScrollableScrollPhysics(),
                              itemCount: mainItems.length,
                              itemBuilder: (BuildContext context, int index) {
                                return Padding(
                                    padding: EdgeInsets.all(8),
                                    child: GestureDetector(
                                        onTap: mainItems[index]['function'],
                                        child: Container(
                                          width:
                                              MediaQuery.of(context).size.width,
                                          child: Row(
                                            children: [
                                              Icon(
                                                mainItems[index]['icon'],
                                                size: istablet ? 38 : 28,
                                              ),
                                              Padding(
                                                  padding: EdgeInsets.only(
                                                      right: 10, left: 8),
                                                  child: Text(
                                                    mainItems[index]['title'],
                                                    textAlign: TextAlign.end,
                                                    style: TextStyle(
                                                        fontSize:
                                                            istablet ? 27 : 18),
                                                  )),
                                            ],
                                          ),
                                        )));
                              },
                              separatorBuilder:
                                  (BuildContext context, int index) {
                                return Divider();
                              },
                            )),
                    ListView.separated(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: items.length,
                      itemBuilder: (BuildContext context, int index) {
                        if (items[index]['title'] == 'الوضع المظلم') {
                          return _buildThemeSwitch(items[index]);
                        }

                        return GestureDetector(
                            onTap: items[index]['function'],
                            child: Padding(
                                padding: EdgeInsets.all(8),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Padding(
                                        padding:
                                            EdgeInsets.only(right: 10, left: 8),
                                        child: Text(
                                          items[index]['title'],
                                          textAlign: TextAlign.end,
                                          style: TextStyle(
                                              fontSize: istablet ? 27 : 18),
                                        )),
                                    Icon(
                                      items[index]['icon'],
                                      size: istablet ? 38 : 28,
                                    ),
                                  ],
                                )));
                      },
                      separatorBuilder: (BuildContext context, int index) {
                        return Divider();
                      },
                    )
                  ])));
  }

  Widget _buildThemeSwitch(Map item) {
    return Padding(
        padding: EdgeInsets.all(8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            Switch(
              activeColor: Theme.of(context).accentColor,
              value: Provider.of<AppProvider>(context).theme ==
                      ThemeConfig.lightTheme
                  ? false
                  : true,
              onChanged: (v) {
                if (v) {
                  Provider.of<AppProvider>(context, listen: false)
                      .setTheme(ThemeConfig.darkTheme, 'dark');
                } else {
                  Provider.of<AppProvider>(context, listen: false)
                      .setTheme(ThemeConfig.lightTheme, 'light');
                }
              },
            ),
            Row(
              children: [
                Padding(
                    padding: EdgeInsets.only(right: 10),
                    child: Text(
                      item['title'],
                      style: TextStyle(fontSize: istablet ? 27 : 18),
                    )),
                Icon(
                  item['icon'],
                  size: istablet ? 38 : 28,
                ),
              ],
            ),
          ],
        ));
  }

  _pushPage(Widget page) {
    MyRouter.pushPage(context, page);
  }

  _pushPageDialog(Widget page) {
    MyRouter.pushPageDialog(context, page);
  }

  final Set<Factory> gestureRecognizers = [
    Factory(() => EagerGestureRecognizer()),
  ].toSet();
  showPayment() {
    Helper.showBottomSheet(
        context,
        WebView(
          gestureRecognizers: gestureRecognizers,
          initialUrl: 'https://newmana.staging-dev.com/shop',
          javascriptMode: JavascriptMode.unrestricted,
          onWebViewCreated: (WebViewController webViewController) {},
          javascriptChannels: <JavascriptChannel>[
            _toasterJavascriptChannel(context),
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
  }

  JavascriptChannel _toasterJavascriptChannel(BuildContext context) {
    return JavascriptChannel(
        name: 'Toaster',
        onMessageReceived: (JavascriptMessage message) {
          // ignore: deprecated_member_use
          Scaffold.of(context).showSnackBar(
            SnackBar(content: Text(message.message)),
          );
        });
  }

  showloginSheet() {
    Helper.showBottomSheet(context,
        CommonSignIn(widget.pageController, true, showLogin), false, showLogin);
  }

  showCreateAccountSheet() {
    Helper.showBottomSheet(
        context,
        CommonSignIn(widget.pageController, false, showLogin),
        false,
        showLogin);
  }

  showAbout() {
    showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          title: Text(
            'عن معنى',
            textAlign: TextAlign.end,
            style: TextStyle(fontSize: istablet ? 32 : 20),
          ),
          content: Text(
            'معنى منصة ثقافية تهتم بنشر المعرفة والفنون، عبر مجموعة متنوعة من المواد المقروءة والمسموعة والمرئية. انطلقت في 20 مارس 2019 ، بهدف إثراء المحتوى العربي عبر الإنتاج الأصيل للمنصة وعبر الترجمة ونقل المعارف.\nفريق العمل:\n بدر الحمود : المؤسس والمدير العام \n سارة الراجحي : شريك مؤسس ومديرة التحرير\n إبراهيم الكلثم : مشرف الترجمة\n فهد الأفندي \n فهد الأفندي : مسؤول العقود والتواصل\n عمر البدران : المشرف على المنتجات الصوتية',
            textAlign: TextAlign.end,
            style: TextStyle(fontSize: istablet ? 27 : 18),
          ),
          actions: <Widget>[
            FlatButton(
              textColor: Theme.of(context).accentColor,
              onPressed: () => Navigator.pop(context),
              child: Text(
                'أغلق',
                textAlign: TextAlign.end,
                style: TextStyle(fontSize: istablet ? 27 : 18),
              ),
            ),
          ],
        );
      },
    );
  }

  // Widget _buildEmailSignUpForm() {
  //   //Form 1
  //   return new Column(
  //     children: <Widget>[
  //       new Container(
  //         height: 51.0,
  //         width: 144.0,
  //         child: new Container(),
  //       ),
  //       new Container(
  //           margin: EdgeInsets.only(
  //               top: 50.0, left: kMarginPadding, right: kMarginPadding),
  //           child: new Text(
  //             "Sign up ",
  //             maxLines: 1,
  //           )),
  //       new Row(
  //         children: <Widget>[
  //           new Expanded(
  //               child: new Container(
  //             padding: EdgeInsets.all(10.0),
  //             margin: EdgeInsets.only(left: kMarginPadding, right: 10.0),
  //             child: new TextFormField(
  //                 style: new TextStyle(
  //                     fontSize: kFontSize, color: Colors.blueGrey),
  //                 controller: _firstNameTextController,
  //                 validator: _validateFields,
  //                 decoration: InputDecoration(
  //                     labelText: "First Name*",
  //                     hintText: "Enter your first name",
  //                     labelStyle: new TextStyle(fontSize: kFontSize))),
  //           )),
  //
  //         ],
  //       ),
  //       SizedBox(
  //         height: 10.0,
  //       ),
  //       new Container(
  //         padding: EdgeInsets.only(left: kMarginPadding, right: kMarginPadding),
  //         margin: EdgeInsets.only(left: 10.0, right: 10.0),
  //         child: new TextFormField(
  //             style: new TextStyle(fontSize: kFontSize, color: Colors.blueGrey),
  //             controller: _phoneTextController,
  //             inputFormatters: [
  //               new BlacklistingTextInputFormatter(new RegExp('[\\.|\\,|\\-]')),
  //             ],
  //             keyboardType: TextInputType.number,
  //             validator: (value) {
  //               if (value.length == 0) {
  //                 return "Please enter your phone number";
  //               } else {
  //                 return null;
  //               }
  //             },
  //             decoration: InputDecoration(
  //                 labelText: "Phone number",
  //                 hintText: "Enter phone number",
  //                 labelStyle: new TextStyle(fontSize: kFontSize))),
  //       ),
  //       SizedBox(
  //         height: 10.0,
  //       ),
  //       new Container(
  //         padding: EdgeInsets.only(left: kMarginPadding, right: kMarginPadding),
  //         margin: EdgeInsets.only(left: 10.0, right: 10.0),
  //         child: new TextFormField(
  //             style: new TextStyle(fontSize: kFontSize, color: Colors.blueGrey),
  //             obscureText: true,
  //             controller: _passwordTextController,
  //             validator: (value) {
  //               if (value.length == 0) {
  //                 return "Password is not valid";
  //               } else if (value.length < 6) {
  //                 return "Please enter atleast 6 characters";
  //               } else {
  //                 return null;
  //               }
  //             },
  //             decoration: InputDecoration(
  //                 labelText: "Password*",
  //                 hintText: "Enter a password",
  //                 labelStyle: new TextStyle(fontSize: kFontSize))),
  //       ),
  //       SizedBox(
  //         height: 10.0,
  //       ),
  //       new RaisedButton(
  //         child: new Text("Sign Up"),
  //         onPressed: () => _signUpButtonTaped(),
  //       ),
  //     ],
  //   );
  // }

  @override
  bool get wantKeepAlive => false;
}
