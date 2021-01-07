import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:maana_main_project_2/components/body_builder.dart';
import 'package:maana_main_project_2/components/book_card.dart';
import 'package:maana_main_project_2/components/book_list_item.dart';
import 'package:maana_main_project_2/genre/genre.dart';
import 'package:maana_main_project_2/models/FeedResponse.dart';
import 'package:maana_main_project_2/util/Helper.dart';
import 'package:maana_main_project_2/util/consts.dart';
import 'package:maana_main_project_2/util/router.dart';
import 'package:maana_main_project_2/view_models/home_provider.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with AutomaticKeepAliveClientMixin {
  bool istablet = false;
  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback(
      (_) => Provider.of<HomeProvider>(context, listen: false).getFeeds(),
    );
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    istablet = Helper.isTablet(context);
    return Consumer<HomeProvider>(
      builder: (BuildContext context, HomeProvider homeProvider, Widget child) {
        return Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: Text(
              '${Constants.appName}',
              style: TextStyle(
                fontSize: istablet ? 30 : 20.0,
              ),
            ),
          ),
          body: _buildBody(homeProvider),
        );
      },
    );
  }

  Widget _buildBody(HomeProvider homeProvider) {
    return BodyBuilder(
      apiRequestStatus: homeProvider.apiRequestStatus,
      child: _buildBodyList(homeProvider),
      reload: () => homeProvider.getFeeds(),
      type: "Home",
    );
  }

  Widget _buildBodyList(HomeProvider homeProvider) {
    return RefreshIndicator(
      onRefresh: () => homeProvider.getFeeds(),
      child: ListView(
        shrinkWrap: true,
        semanticChildCount: 10,
        addAutomaticKeepAlives: true,
        children: <Widget>[
          _buildFeaturedSection(homeProvider),
          SizedBox(height: istablet ? 30 : 20.0),
          _buildSectionTitle('التصنيفات'),
          SizedBox(height: 10.0),
          _buildGenreSection(homeProvider),
          SizedBox(height: istablet ? 30 : 20.0),
          _buildSectionTitle('أضيف مؤخرا'),
          SizedBox(height: istablet ? 30 : 20.0),
          _buildNewSection(homeProvider),
        ],
      ),
    );
  }

  _buildSectionTitle(String title) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Text(
            '$title',
            textAlign: TextAlign.right,
            style: TextStyle(
                fontSize: istablet ? 35 : 20.0,
                fontWeight: FontWeight.w500,
                color: Theme.of(context).accentColor),
          ),
        ],
      ),
    );
  }

  _buildFeaturedSection(HomeProvider homeProvider) {
    return Container(
      height: istablet ? 300 : 200.0,
      child: ListView.builder(
        primary: false,
        padding: EdgeInsets.symmetric(horizontal: istablet ? 25 : 15.0),
        scrollDirection: Axis.horizontal,
        itemCount: homeProvider.top.length > 0 ? homeProvider.top.length : 0,
        shrinkWrap: true,
        reverse: false,
        itemBuilder: (BuildContext context, int index) {
          Books entry = homeProvider.top[index];
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 5.0, vertical: 10.0),
            child: BookCard(
              img: entry.imageUrl != null
                  ? entry.imageUrl
                  : "https://cdn-thumbs.imagevenue.com/b4/af/96/ME12I13L_t.png",
              book: entry,
              isTablet: istablet,
            ),
          );
        },
      ),
    );
  }

  _buildGenreSection(HomeProvider homeProvider) {
    return Container(
      height: istablet ? 75 : 50.0,
      child: ListView.builder(
        primary: false,
        padding: EdgeInsets.symmetric(horizontal: 15.0),
        scrollDirection: Axis.horizontal,
        reverse: true,
        itemCount: homeProvider?.categories?.length ?? 0,
        shrinkWrap: true,
        itemBuilder: (BuildContext context, int index) {
          Categories category = homeProvider.categories[index];

          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 5.0, vertical: 10.0),
            child: Container(
              decoration: BoxDecoration(
                color: Theme.of(context).accentColor,
                borderRadius: BorderRadius.all(
                  Radius.circular(20.0),
                ),
              ),
              child: InkWell(
                borderRadius: BorderRadius.all(
                  Radius.circular(20.0),
                ),
                onTap: () {
                  MyRouter.pushPage(
                    context,
                    Genre(
                      title: '${category.label}',
                      url: category.url,
                    ),
                  );
                },
                child: Center(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10.0),
                    child: Text(
                      '${category.label}',
                      textDirection: TextDirection.rtl,
                      textAlign: TextAlign.center,
                      softWrap: true,
                      maxLines: 1,
                      style: TextStyle(
                        fontSize: istablet ? 20 : 13,
                        color: Theme.of(context).scaffoldBackgroundColor,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  _buildNewSection(HomeProvider homeProvider) {
    return ListView.builder(
      padding: EdgeInsets.symmetric(horizontal: 15.0),
      reverse: true,
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: homeProvider?.recent?.length ?? 0,
      itemBuilder: (BuildContext context, int index) {
        Books entry = homeProvider.recent[index];

        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 5.0, vertical: 5.0),
          child: BookListItem(
            img: entry.imageUrl != null
                ? entry.imageUrl
                : "https://cdn-thumbs.imagevenue.com/b4/af/96/ME12I13L_t.png",
            title: entry.title,
            author: "",
            desc: entry.summary,
            entry: entry,
            istablet: istablet,
          ),
        );
      },
    );
  }

  @override
  bool get wantKeepAlive => true;
}
