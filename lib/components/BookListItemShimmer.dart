import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:maana_main_project_2/components/loading_widget.dart';
import 'package:maana_main_project_2/util/Helper.dart';

class BookListItemShimmer extends StatelessWidget {
  bool isTablet;

  BookListItemShimmer({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    isTablet = Helper.isTablet(context);
    return InkWell(
      child: Container(
        height: isTablet ? 300 : 150.0,
        child: Row(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Flexible(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  Material(
                      type: MaterialType.transparency,
                      child: Container(
                          alignment: Alignment.topRight,
                          height: isTablet ? 30 : 15,
                          decoration: new BoxDecoration(
                              color: Colors.black,
                              borderRadius: new BorderRadius.only(
                                topLeft: const Radius.circular(25.0),
                                topRight: const Radius.circular(25.0),
                                bottomLeft: const Radius.circular(25.0),
                                bottomRight: const Radius.circular(25.0),
                              )))),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                      alignment: Alignment.topRight,
                      height: isTablet ? 30 : 15,
                      decoration: new BoxDecoration(
                          color: Colors.black,
                          borderRadius: new BorderRadius.only(
                            topLeft: const Radius.circular(25.0),
                            topRight: const Radius.circular(25.0),
                            bottomLeft: const Radius.circular(25.0),
                            bottomRight: const Radius.circular(25.0),
                          ))),
                  SizedBox(height: isTablet ? 30 : 15.0),
                  Container(
                      alignment: Alignment.topRight,
                      height: isTablet ? 30 : 15,
                      decoration: new BoxDecoration(
                          color: Colors.black,
                          borderRadius: new BorderRadius.only(
                            topLeft: const Radius.circular(25.0),
                            topRight: const Radius.circular(25.0),
                            bottomLeft: const Radius.circular(25.0),
                            bottomRight: const Radius.circular(25.0),
                          ))),
                ],
              ),
            ),
            SizedBox(width: 10.0),
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(10.0),
                ),
              ),
              elevation: 4,
              child: ClipRRect(
                borderRadius: BorderRadius.all(
                  Radius.circular(10.0),
                ),
                child: CachedNetworkImage(
                  imageUrl: "",
                  placeholder: (context, url) => Container(
                    height: isTablet ? 300 : 150.0,
                    width: isTablet ? 200 : 100.0,
                    child: LoadingWidget(
                      isImage: true,
                    ),
                  ),
                  errorWidget: (context, url, error) => Image.asset(
                    'assets/images/logo.jpg',
                    fit: BoxFit.cover,
                    height: isTablet ? 300 : 150.0,
                    width: isTablet ? 200 : 100.0,
                  ),
                  fit: BoxFit.cover,
                  height: isTablet ? 300 : 150.0,
                  width: isTablet ? 200 : 100.0,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
