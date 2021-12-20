import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:maana_main_project_2/Viewsz/details/details.dart';
import 'package:maana_main_project_2/components/loading_widget.dart';
import 'package:maana_main_project_2/models/FeedResponse.dart';
import 'package:maana_main_project_2/util/router.dart';
import 'package:uuid/uuid.dart';

class BookCard extends StatelessWidget {
  final String img;
  final Books book;
  final bool isTablet;

  BookCard({
    Key key,
    @required this.img,
    @required this.book,
    this.isTablet = false,
  }) : super(key: key);

  static final uuid = Uuid();
  final String imgTag = uuid.v4();
  final String titleTag = uuid.v4();
  final String authorTag = uuid.v4();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: isTablet ? 200 : 120.0,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(10.0),
          ),
        ),
        elevation: 4.0,
        child: InkWell(
          borderRadius: BorderRadius.all(
            Radius.circular(10.0),
          ),
          onTap: () {
            if (book != null) {
              MyRouter.pushPage(
                context,
                Details(
                  book: book,
                  imgTag: imgTag,
                  titleTag: titleTag,
                  authorTag: authorTag,
                ),
              );
            }
          },
          child: CachedNetworkImage(
            imageUrl: img != null
                ? img
                : "https://cdn-thumbs.imagevenue.com/b4/af/96/ME12I13L_t.png",
            placeholder: (context, url) => LoadingWidget(
              isImage: true,
            ),
            errorWidget: (context, url, error) => Image.asset(
              'assets/images/logo.jpg',
              fit: BoxFit.cover,
            ),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
