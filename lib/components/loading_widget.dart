import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:maana_main_project_2/components/BookListItemShimmer.dart';
import 'package:maana_main_project_2/components/book_card.dart';
import 'package:maana_main_project_2/util/Helper.dart';
import 'package:shimmer/shimmer.dart';

class LoadingWidget extends StatelessWidget {
  final bool isImage;
  static bool isTablet;
  final String type;

  LoadingWidget({this.isImage = false, this.type});

  @override
  Widget build(BuildContext context) {
    return _buildBody(context);
  }

  _buildBody(BuildContext context) {
    isTablet = Helper.isTablet(context);

    if (isImage) {
      return Center(
          child: SpinKitRipple(
        color: Theme.of(context).accentColor,
      ));
    } else {
      debugPrint("type $type");
      switch (type) {
        case "Home":
          return SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: Shimmer.fromColors(
                child: ListView(
                  children: <Widget>[
                    _buildFeaturedSection(),
                    SizedBox(height: 20.0),
                    _buildSectionTitle(),
                    SizedBox(height: 10.0),
                    _buildGenreSection(),
                    SizedBox(height: 20.0),
                    _buildSectionTitle(),
                    SizedBox(height: 20.0),
                    _buildNewSection(),
                  ],
                ),
                baseColor: Color(0xFFEAEAEA),
                highlightColor: Color(0xFFcfd8dc),
                direction: ShimmerDirection.rtl,
              ));
          break;

        case "Explore":
          return SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: Shimmer.fromColors(
                child: ListView(
                  children: <Widget>[
                    // _buildSectionHeader(),
                    _buildSectionTitle(),
                    _buildFeaturedSection(),
                    _buildSectionTitle(),
                    _buildFeaturedSection(),
                    _buildSectionTitle(),
                    _buildFeaturedSection(),
                  ],
                ),
                baseColor: Color(0xFFEAEAEA),
                highlightColor: Color(0xFFcfd8dc),
                direction: ShimmerDirection.rtl,
              ));
          break;
        case "list":
          return SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: Shimmer.fromColors(
                baseColor: Color(0xFFEAEAEA),
                highlightColor: Color(0xFFcfd8dc),
                direction: ShimmerDirection.rtl,
                child: ListView(children: <Widget>[_buildNewSection()]),
              ));
          break;
        case "Book":
          return SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: Shimmer.fromColors(
                baseColor: Color(0xFFEAEAEA),
                highlightColor: Color(0xFFcfd8dc),
                direction: ShimmerDirection.rtl,
                child: _buildNewSection(),
              ));
          break;
      }
    }
  }

  _buildSectionHeader() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          Container(
            height: 5,
            width: 25,
            color: Colors.grey,
          ),
          Container(
            height: 5,
            width: 25,
          ),
        ],
      ),
    );
  }

  _buildSectionTitle() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Container(
              width: isTablet ? 200 : 100,
              height: isTablet ? 25 : 15,
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
    );
  }

  static _buildFeaturedSection() {
    return Container(
      height: isTablet ? 300 : 200.0,
      alignment: Alignment.topRight,
      child: ListView.builder(
        padding: EdgeInsets.symmetric(horizontal: 15.0),
        scrollDirection: Axis.horizontal,
        itemCount: 5,
        shrinkWrap: true,
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 5.0, vertical: 10.0),
            child: BookCard(
              img: "",
              book: null,
              isTablet: isTablet,
            ),
          );
        },
      ),
    );
  }

  _buildGenreSection() {
    return Container(
      height: isTablet ? 100 : 50.0,
      child: ListView.builder(
        primary: false,
        padding: EdgeInsets.symmetric(horizontal: 15.0),
        scrollDirection: Axis.horizontal,
        reverse: true,
        itemCount: 10,
        shrinkWrap: true,
        itemBuilder: (BuildContext context, int index) {
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
                child: Center(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10.0),
                    child: Text(
                      "this is a title",
                      style: TextStyle(
                        color: Theme.of(context).scaffoldBackgroundColor,
                        fontSize: isTablet ? 12 : 8,
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

  _buildNewSection() {
    return ListView.builder(
      primary: false,
      padding: EdgeInsets.symmetric(horizontal: 15.0),
      shrinkWrap: true,
      reverse: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: 10,
      itemBuilder: (BuildContext context, int index) {
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 5.0, vertical: 5.0),
          child: BookListItemShimmer(),
        );
      },
    );
  }
}
