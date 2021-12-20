import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:maana_main_project_2/Viewsz/details/details.dart';
import 'package:maana_main_project_2/components/loading_widget.dart';
import 'package:maana_main_project_2/models/FeedResponse.dart';
import 'package:maana_main_project_2/util/router.dart';
import 'package:uuid/uuid.dart';

class BookListItem extends StatelessWidget {
  final String img;
  final String title;
  final String author;
  final String desc;
  final Books entry;
  final bool istablet;

  BookListItem({
    Key key,
    @required this.img,
    @required this.title,
    @required this.author,
    @required this.desc,
    @required this.entry,
    this.istablet = false,
  }) : super(key: key);

  static final uuid = Uuid();
  final String imgTag = uuid.v4();
  final String titleTag = uuid.v4();
  final String authorTag = uuid.v4();

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        MyRouter.pushPage(
          context,
          Details(
            book: entry,
            authorTag: authorTag,
            imgTag: imgTag,
            titleTag: titleTag,
          ),
        );
      },
      child: Container(
        height: istablet ? 250 : 150.0,
        child: Row(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            Flexible(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  Hero(
                    tag: titleTag,
                    child: Material(
                      type: MaterialType.transparency,
                      child: Text(
                        title != null ? title : '',
                        textAlign: TextAlign.right,
                        style: TextStyle(
                          fontSize: istablet ? 25 : 17.0,
                          fontWeight: FontWeight.w900,
                          color: Theme.of(context).textTheme.headline6.color,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                  //TODO add author
                  // SizedBox(
                  //   height: 5,
                  // ),
                  // Hero(
                  //   tag: authorTag,
                  //   child: Material(
                  //     type: MaterialType.transparency,
                  //     child: Text(
                  //       'مارسيل موسى',
                  //       style: TextStyle(
                  //         fontSize: 14.0,
                  //         fontWeight: FontWeight.w800,
                  //         color: Theme.of(context).accentColor,
                  //       ),
                  //     ),
                  //   ),
                  // ),
                  SizedBox(height: 10.0),
                  Text(
                    desc != null ? desc : "",
                    textAlign: TextAlign.right,
                    maxLines: istablet ? 3 : 2,
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: istablet ? 23 : 13.0,
                      color: Theme.of(context).textTheme.headline6.color,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(width: istablet ? 20 : 10.0),
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(10.0),
                ),
              ),
              elevation: 4,
              child: CachedNetworkImage(
                imageUrl: entry.imageUrl != null
                    ? entry.imageUrl
                    : "https://cdn-thumbs.imagevenue.com/b4/af/96/ME12I13L_t.png",
                placeholder: (context, url) => Container(
                  height: istablet ? 300 : 150.0,
                  width: istablet ? 200 : 100.0,
                  child: LoadingWidget(
                    isImage: true,
                  ),
                ),
                errorWidget: (context, url, error) => Image.asset(
                  'assets/images/logo.jpg',
                  fit: BoxFit.cover,
                  height: istablet ? 300 : 150.0,
                  width: istablet ? 200 : 100.0,
                ),
                fit: BoxFit.cover,
                height: istablet ? 300 : 150.0,
                width: istablet ? 200 : 100.0,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
