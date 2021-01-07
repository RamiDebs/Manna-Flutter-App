import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:maana_main_project_2/components/body_builder.dart';
import 'package:maana_main_project_2/components/book_card.dart';
import 'package:maana_main_project_2/components/loading_widget.dart';
import 'package:maana_main_project_2/genre/genre.dart';
import 'package:maana_main_project_2/models/ExploreResponse.dart';
import 'package:maana_main_project_2/models/FeedResponse.dart';
import 'package:maana_main_project_2/util/Helper.dart';
import 'package:maana_main_project_2/util/api.dart';
import 'package:maana_main_project_2/util/router.dart';
import 'package:maana_main_project_2/view_models/ExploreProvider.dart';
import 'package:provider/provider.dart';

class Explore extends StatefulWidget {
  @override
  _ExploreState createState() => _ExploreState();
}

class _ExploreState extends State<Explore> with AutomaticKeepAliveClientMixin {
  Api api = Api();
  bool isTablet = false;
  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback(
      (_) => Provider.of<ExploreProvider>(context, listen: false).getExplore(),
    );
  }

  @override
  Widget build(BuildContext context) {
    isTablet = Helper.isTablet(context);
    super.build(context);
    return Consumer<ExploreProvider>(
      builder:
          (BuildContext context, ExploreProvider homeProvider, Widget child) {
        return Scaffold(
            appBar: AppBar(
              centerTitle: true,
              title: Text(
                'اصدارات و كتب',
                style: TextStyle(
                  fontSize: isTablet ? 30 : 20.0,
                ),
              ),
            ),
            body: _buildBody(homeProvider));
      },
    );
  }

  Widget _buildBody(ExploreProvider homeProvider) {
    return BodyBuilder(
      apiRequestStatus: homeProvider.apiRequestStatus,
      child: _buildBodyList(homeProvider),
      reload: () => homeProvider.getExplore(),
      type: "Explore",
    );
  }

  _buildBodyList(ExploreProvider homeProvider) {
    return RefreshIndicator(
        onRefresh: () => homeProvider.getExplore(),
        child: ListView.builder(
          itemCount: homeProvider.exploreResponse.categories != null
              ? homeProvider.exploreResponse.categories.length
              : 0,
          itemBuilder: (BuildContext context, int index) {
            Category category = homeProvider.exploreResponse.categories[index];

            return Padding(
              padding: EdgeInsets.symmetric(vertical: 10.0),
              child: Column(
                children: <Widget>[
                  _buildSectionHeader(category),
                  SizedBox(height: 10.0),
                  _buildSectionBookList(category),
                ],
              ),
            );
          },
        ));
  }

  _buildSectionHeader(Category category) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          GestureDetector(
            onTap: () {
              MyRouter.pushPage(
                context,
                Genre(
                  title: '${category.label}',
                  url: category.url,
                ),
              );
            },
            child: Text(
              'المزيد',
              style: TextStyle(
                color: Theme.of(context).accentColor,
                fontWeight: FontWeight.w400,
                fontSize: isTablet ? 20 : 12.0,
              ),
            ),
          ),
          Flexible(
            child: Text(
              category.label,
              style: TextStyle(
                fontSize: isTablet ? 30 : 20.0,
                color: Theme.of(context).accentColor,
                fontWeight: FontWeight.w500,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }

  _buildSectionBookList(Category category) {
    if (category.books.length > 0) {
      return Container(
        alignment: Alignment.topRight,
        height: isTablet ? 300 : 200.0,
        child: ListView.builder(
          padding: EdgeInsets.symmetric(horizontal: 15.0),
          scrollDirection: Axis.horizontal,
          itemCount: category.books.length,
          shrinkWrap: true,
          reverse: true,
          itemBuilder: (BuildContext context, int index) {
            Books entry = category.books[index];

            return Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 5.0,
                vertical: 10.0,
              ),
              child: BookCard(
                img: entry.imageUrl != null
                    ? entry.imageUrl
                    : "https://cdn-thumbs.imagevenue.com/b4/af/96/ME12I13L_t.png",
                book: entry,
                isTablet: isTablet,
              ),
            );
          },
        ),
      );
    } else {
      return Container(
        height: 200.0,
        child: LoadingWidget(
          type: "Explore",
        ),
      );
    }
    return Container(
      height: 200.0,
      child: LoadingWidget(
        type: "Explore",
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
