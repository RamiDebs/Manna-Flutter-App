import 'package:flutter/material.dart';
import 'package:maana_main_project_2/util/Helper.dart';

class DescriptionTextWidget extends StatefulWidget {
  final String text;

  DescriptionTextWidget({@required this.text});

  @override
  _DescriptionTextWidgetState createState() => _DescriptionTextWidgetState();
}

class _DescriptionTextWidgetState extends State<DescriptionTextWidget> {
  String firstHalf;
  String secondHalf;

  bool flag = true;
  bool istablet = true;

  @override
  void initState() {
    super.initState();

    if (widget.text.length > 300) {
      firstHalf = widget.text.substring(0, 300);
      secondHalf = widget.text.substring(300, widget.text.length);
    } else {
      firstHalf = widget.text;
      secondHalf = '';
    }
  }

  @override
  Widget build(BuildContext context) {
    istablet = Helper.isTablet(context);
    return Container(
      child: secondHalf.isEmpty
          ? Text(
              '${flag ? (firstHalf) : (firstHalf + secondHalf)}'
                  .replaceAll(r'\n', '\n')
                  .replaceAll(r'\r', '')
                  .replaceAll(r"\'", "'"),
              textAlign: TextAlign.right,
              style: TextStyle(
                fontSize: istablet ? 25 : 16.0,
                color: Theme.of(context).textTheme.headline6.color,
              ),
            )
          : Column(
              children: <Widget>[
                Text(
                  '${flag ? (firstHalf + '...') : (firstHalf + secondHalf)}'
                      .replaceAll(r'\n', '\n\n')
                      .replaceAll(r'\r', '')
                      .replaceAll(r"\'", "'"),
                  textAlign: TextAlign.right,
                  style: TextStyle(
                    fontSize: istablet ? 25 : 16.0,
                    color: Theme.of(context).textTheme.headline6.color,
                  ),
                ),
                GestureDetector(
                  child: Padding(
                      padding: EdgeInsets.only(top: 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            flag ? 'أظهر المزيد' : 'أظهر أقل',
                            style: TextStyle(
                                color: Theme.of(context).accentColor,
                                fontSize: istablet ? 25 : 16),
                          ),
                        ],
                      )),
                  onTap: () {
                    setState(() {
                      flag = !flag;
                    });
                  },
                ),
              ],
            ),
    );
  }
}
