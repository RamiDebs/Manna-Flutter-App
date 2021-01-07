import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:maana_main_project_2/PDF/PDFView.dart';
import 'package:maana_main_project_2/components/description_text.dart';
import 'package:maana_main_project_2/components/loading_widget.dart';
import 'package:maana_main_project_2/genre/genre.dart';
import 'package:maana_main_project_2/models/FeedResponse.dart';
import 'package:maana_main_project_2/util/Helper.dart';
import 'package:maana_main_project_2/util/router.dart';
import 'package:maana_main_project_2/util/shared_preferences_helper.dart';
import 'package:maana_main_project_2/view_models/details_provider.dart';
import 'package:provider/provider.dart';

class Details extends StatefulWidget {
  final Books book;
  final String imgTag;
  final String titleTag;
  final String authorTag;

  Details({
    Key key,
    @required this.book,
    @required this.imgTag,
    @required this.titleTag,
    @required this.authorTag,
  }) : super(key: key);

  @override
  _DetailsState createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  AppLocalData appLocalData;
  bool istablet = false;
  @override
  void initState() {
    super.initState();
    appLocalData = AppLocalData();
    SchedulerBinding.instance.addPostFrameCallback(
      (_) {
        Provider.of<DetailsProvider>(context, listen: false)
            .setEntry(widget.book);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    istablet = Helper.isTablet(context);

    return Consumer<DetailsProvider>(
      builder: (BuildContext context, DetailsProvider detailsProvider,
          Widget child) {
        return Scaffold(
          appBar: AppBar(),
          body: ListView(
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            children: <Widget>[
              SizedBox(height: istablet ? 15 : 10.0),
              _buildImageTitleSection(detailsProvider),
              SizedBox(height: istablet ? 40 : 30.0),
              _buildSectionTitle('وصف الكتاب'),
              _buildDivider(),
              SizedBox(height: istablet ? 15 : 10.0),
              DescriptionTextWidget(
                text: '${widget.book.summary}',
              ),
              SizedBox(height: 30.0),
              // _buildSectionTitle('المزيد من المؤلف'),
              // _buildDivider(),
              // SizedBox(height: 10.0),
              // _buildMoreBook(detailsProvider),
            ],
          ),
        );
      },
    );
  }

  _buildDivider() {
    return Divider(
      color: Theme.of(context).textTheme.caption.color,
    );
  }

  _buildImageTitleSection(DetailsProvider detailsProvider) {
    return Container(
      child: Row(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          SizedBox(width: 20.0),
          Flexible(
            child: Padding(
                padding: EdgeInsets.only(right: istablet ? 10 : 5),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    Hero(
                      tag: widget.titleTag,
                      child: Material(
                        type: MaterialType.transparency,
                        child: Text(
                          '${widget.book.title}',
                          textAlign: TextAlign.right,
                          style: TextStyle(
                            fontSize: istablet ? 35 : 20.0,
                            fontWeight: FontWeight.bold,
                          ),
                          maxLines: 3,
                        ),
                      ),
                    ),
                    //TODO add auth
                    // SizedBox(height: 5.0),
                    // Hero(
                    //   tag: widget.authorTag,
                    //   child: Material(
                    //     type: MaterialType.transparency,
                    //     child: Text(
                    //       '${widget.book.author.name.t}',
                    //       style: TextStyle(
                    //         fontSize: 16.0,
                    //         fontWeight: FontWeight.w800,
                    //         color: Colors.grey,
                    //       ),
                    //     ),
                    //   ),
                    // ),
                    SizedBox(height: 5.0),
                    _buildCategory(widget.book, context),
                    Padding(
                        padding: EdgeInsets.only(top: istablet ? 12 : 8),
                        child: GestureDetector(
                          onTap: () {
                            AppLocalData().getIsUserLoggedIn().then((value) {
                              if (value) {
                                MyRouter.pushPage(
                                    context,
                                    PDFPage(
                                      path: widget.book.pdfUrl,
                                    ));
                              } else {
                                Helper.showErrorBottomSheet(context, istablet);
                              }
                            });
                          },
                          child: Container(
                            width: istablet ? 350 : 250,
                            decoration: new BoxDecoration(
                                color: Theme.of(context).accentColor,
                                borderRadius: new BorderRadius.all(
                                    Radius.circular(40.0))),
                            child: Text(
                              "تصفح الكتاب",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: istablet ? 25 : 18,
                                  color: Theme.of(context)
                                      .scaffoldBackgroundColor),
                            ),
                          ),
                        )),
                  ],
                )),
          ),
          SizedBox(height: istablet ? 15 : 5.0),
          Hero(
            tag: widget.imgTag,
            child: CachedNetworkImage(
              imageUrl: '${widget.book.imageUrl}',
              placeholder: (context, url) => Container(
                height: istablet ? 300 : 200.0,
                width: istablet ? 200 : 130.0,
                child: LoadingWidget(
                  isImage: true,
                ),
              ),
              errorWidget: (context, url, error) => Icon(Feather.x),
              fit: BoxFit.cover,
              height: istablet ? 300 : 200.0,
              width: istablet ? 200 : 130.0,
            ),
          ),
        ],
      ),
    );
  }

  _buildSectionTitle(String title) {
    return Text(
      '$title',
      textAlign: TextAlign.right,
      style: TextStyle(
        color: Theme.of(context).accentColor,
        fontSize: istablet ? 30 : 20.0,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  // _buildMoreBook(DetailsProvider provider) {
  //   if (provider.loading) {
  //     return Container(
  //       height: 200.0,
  //       child: LoadingWidget(
  //         isImage: false,
  //         type: "list",
  //       ),
  //     );
  //   } else {
  //     return ListView.builder(
  //       shrinkWrap: true,
  //       physics: NeverScrollableScrollPhysics(),
  //       itemCount: provider.related.feed.entry.length,
  //       itemBuilder: (BuildContext context, int index) {
  //         Entry entry = provider.related.feed.entry[index];
  //         return Padding(
  //           padding: EdgeInsets.symmetric(vertical: 5.0),
  //           child: BookListItem(
  //             img: entry.link[1].href,
  //             title: entry.title.t,
  //             author: entry.author.name.t,
  //             desc: entry.summary.t,
  //             entry: entry,
  //           ),
  //         );
  //       },
  //     );
  //   }
  // }

  _buildCategory(Books entry, BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    if (entry.tags == null) {
      return SizedBox();
    } else {
      return Directionality(
        textDirection: TextDirection.rtl,
        child: Container(
            alignment: Alignment.topRight,
            height: entry.tags.length < 3
                ? istablet
                    ? 95
                    : 55.0
                : istablet
                    ? 125
                    : 95.0,
            width: istablet ? 300 : 250,
            child: GridView.builder(
              reverse: false,
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: entry.tags.length > 4 ? 4 : entry.tags.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 210 / 80,
              ),
              itemBuilder: (BuildContext context, int index) {
                Tags cat = entry.tags[index];
                return Padding(
                  padding: EdgeInsets.fromLTRB(0.0, 5.0, 5.0, 5.0),
                  child: GestureDetector(
                      onTap: () {
                        MyRouter.pushPage(
                          context,
                          Genre(
                            title: '${cat.name}',
                            url: cat.url ??
                                "https://mana.domvp.xyz/wp-json/mana-flutter/v2/category?cat=100",
                          ),
                        );
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: Theme.of(context).backgroundColor,
                          borderRadius: BorderRadius.all(
                            Radius.circular(20),
                          ),
                          border: Border.all(
                            color: Theme.of(context).accentColor,
                          ),
                        ),
                        child: Center(
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: istablet ? 8 : 2.0),
                            child: Text(
                              '${cat.name}',
                              maxLines: 1,
                              textAlign: TextAlign.center,
                              overflow: TextOverflow.fade,
                              softWrap: true,
                              style: TextStyle(
                                color: Theme.of(context).accentColor,
                                fontSize: istablet
                                    ? cat.name.length > 18
                                        ? 18
                                        : 23.0
                                    : cat.name.length > 18
                                        ? 6.0
                                        : 10.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      )),
                );
              },
            )),
      );
    }
  }
}
