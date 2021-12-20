import 'package:flutter/material.dart';
import 'package:maana_main_project_2/splash/splash.dart';
import 'package:maana_main_project_2/theme/theme_config.dart';
import 'package:maana_main_project_2/util/consts.dart';
import 'package:maana_main_project_2/view_models/ExploreProvider.dart';
import 'package:maana_main_project_2/view_models/ProfileProvider.dart';
import 'package:maana_main_project_2/view_models/app_provider.dart';
import 'package:maana_main_project_2/view_models/details_provider.dart';
import 'package:maana_main_project_2/view_models/genre_provider.dart';
import 'package:maana_main_project_2/view_models/home_provider.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AppProvider()),
        ChangeNotifierProvider(create: (_) => GenreProvider()),
        ChangeNotifierProvider(create: (_) => HomeProvider()),
        ChangeNotifierProvider(create: (_) => ExploreProvider()),
        ChangeNotifierProvider(create: (_) => ProfileProvider()),
        ChangeNotifierProvider(create: (_) => DetailsProvider()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Consumer<AppProvider>(
      builder: (BuildContext context, AppProvider appProvider, Widget child) {
        return MaterialApp(
          key: appProvider.key,
          debugShowCheckedModeBanner: false,
          navigatorKey: appProvider.navigatorKey,
          title: Constants.appName,
          theme: themeData(appProvider.theme),
          darkTheme: themeData(ThemeConfig.darkTheme),
          home: Splash(),
        );
      },
    );
  }

  ThemeData themeData(ThemeData theme) {
    return theme.copyWith();
  }
}
