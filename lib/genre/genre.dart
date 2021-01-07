import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:maana_main_project_2/components/body_builder.dart';
import 'package:maana_main_project_2/components/book_list_item.dart';
import 'package:maana_main_project_2/components/loading_widget.dart';
import 'package:maana_main_project_2/models/FeedResponse.dart';
import 'package:maana_main_project_2/util/Helper.dart';
import 'package:maana_main_project_2/view_models/genre_provider.dart';
import 'package:provider/provider.dart';

class Genre extends StatefulWidget {
  final String title;
  final String url;

  Genre({
    Key key,
    @required this.title,
    @required this.url,
  }) : super(key: key);

  @override
  _GenreState createState() => _GenreState();
}

class _GenreState extends State<Genre> {
  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback(
      (_) => Provider.of<GenreProvider>(context, listen: false)
          .getFeed(widget.url),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (BuildContext context, GenreProvider provider, Widget child) {
        return Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: Text('${widget.title}'),
          ),
          body: _buildBody(provider),
        );
      },
    );
  }

  Widget _buildBody(GenreProvider provider) {
    return BodyBuilder(
      apiRequestStatus: provider.apiRequestStatus,
      child: _buildBodyList(provider),
      reload: () => provider.getFeed(widget.url),
      type: "list",
    );
  }

  _buildBodyList(GenreProvider provider) {
    bool isTablet = Helper.isTablet(context);
    return ListView(
      controller: provider.controller,
      children: <Widget>[
        ListView.builder(
          physics: NeverScrollableScrollPhysics(),
          padding: EdgeInsets.symmetric(horizontal: 10.0),
          shrinkWrap: true,
          itemCount: provider.items.length,
          itemBuilder: (BuildContext context, int index) {
            Books entry = provider.items[index];
            return Padding(
              padding: EdgeInsets.all(5.0),
              child: BookListItem(
                author: null,
                img: entry.imageUrl != null
                    ? entry.imageUrl
                    : "https://cdn-thumbs.imagevenue.com/b4/af/96/ME12I13L_t.png",
                title: entry.title,
                desc: entry.summary,
                entry: entry,
                istablet: isTablet,
              ),
            );
          },
        ),
        SizedBox(height: 10.0),
        provider.loadingMore
            ? Container(
                height: 80.0,
                child: _buildProgressIndicator(),
              )
            : SizedBox(),
      ],
    );
  }

  _buildProgressIndicator() {
    return LoadingWidget(
      type: "Book",
    );
  }
}
