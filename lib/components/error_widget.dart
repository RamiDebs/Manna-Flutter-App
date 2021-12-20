import 'package:flutter/material.dart';
import 'package:maana_main_project_2/util/Helper.dart';

class WidgetError extends StatelessWidget {
  final Function refreshCallBack;
  final bool isConnection;
  final bool isnoBooks;
  bool isTablet;

  WidgetError({
    @required this.refreshCallBack,
    this.isConnection = false,
    this.isnoBooks = false,
  });

  @override
  Widget build(BuildContext context) {
    isTablet = Helper.isTablet(context);
    return Container(
      alignment: Alignment.center,
      margin: EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Icon(
            isnoBooks ? Icons.library_books : Icons.network_check,
            size: isTablet ? 120 : 60,
          ),
          Container(
            margin: EdgeInsets.only(bottom: 15.0),
            child: Text(
              getErrorText(),
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Theme.of(context).textTheme.headline6.color,
                fontSize: isTablet ? 30 : 17.0,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          Container(
            child: RaisedButton(
              onPressed: refreshCallBack,
              color: Theme.of(context).accentColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5.0),
              ),
              child: Text(
                'حاول مرة اخرى',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Theme.of(context).primaryColor,
                  fontSize: isTablet ? 25 : 15.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  getErrorText() {
    if (isnoBooks) {
      return 'لا يوجد كتب \n الرجاء المحاولة مرة أخرى';
    }
    if (isConnection) {
      return 'هناك مشكلة في اتصالك بالإنترنت \n الرجاء المحاولة مرة أخرى';
    } else {
      return 'لا يمكن تحميل هذه الصفحة \n حاول مرة أخرى';
    }
  }
}
