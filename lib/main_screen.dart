import 'package:ff_navigation_bar/ff_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:maana_main_project_2/explore/explore.dart';
import 'package:maana_main_project_2/util/Helper.dart';
import 'package:maana_main_project_2/util/dialogs.dart';
import 'package:maana_main_project_2/views/settings/settings.dart';

import 'home.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  PageController pageController;
  int _page = 2;
  bool istablet;

  @override
  Widget build(BuildContext context) {
    istablet = Helper.isTablet(context);
    return WillPopScope(
      onWillPop: () => Dialogs().showExitDialog(context),
      child: Scaffold(
        body: PageView(
          physics: NeverScrollableScrollPhysics(),
          controller: pageController,
          onPageChanged: onPageChanged,
          children: <Widget>[
            Profile(pageController),
            Explore(),
            Home(),
          ],
        ),
        bottomNavigationBar: FFNavigationBar(
          theme: FFNavigationBarTheme(
            barHeight: istablet ? 100 : 60,
            showSelectedItemShadow: true,
            selectedItemTextStyle: TextStyle(fontSize: istablet ? 30 : 15),
            unselectedItemTextStyle: TextStyle(fontSize: istablet ? 30 : 15),
            barBackgroundColor: Theme.of(context).primaryColor,
            unselectedItemIconColor: Theme.of(context).bottomAppBarColor,
            unselectedItemLabelColor: Theme.of(context).bottomAppBarColor,
            selectedItemBorderColor: Colors.transparent,
            selectedItemBackgroundColor: Color(0xff2B2825),
            selectedItemIconColor: Theme.of(context).selectedRowColor,
            selectedItemLabelColor: Theme.of(context).accentColor,
          ),
          selectedIndex: _page,
          onSelectTab: (index) {
            setState(() {
              _page = index;
              pageController.jumpToPage(index);
            });
          },
          items: [
            FFNavigationBarItem(
              iconData: Icons.account_circle,
              label: 'حسابي',
            ),
            FFNavigationBarItem(
              iconData: Icons.library_books,
              itemWidth: istablet ? 300 : 25,
              label: 'المكتبة',
            ),
            FFNavigationBarItem(
              iconData: Icons.home,
              label: 'الرئيسية',
            ),
          ],
        ),
      ),
    );
  }

  void navigationTapped(int page) {
    pageController.jumpToPage(page);
  }

  @override
  void initState() {
    super.initState();
    pageController = PageController(initialPage: 3);
  }

  @override
  void dispose() {
    super.dispose();
    pageController.dispose();
  }

  void onPageChanged(int page) {
    setState(() {
      this._page = page;
    });
  }
}
