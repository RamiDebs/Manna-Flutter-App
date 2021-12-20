import 'dart:io';

import 'package:flutter/material.dart';
import 'package:maana_main_project_2/components/custom_alert.dart';
import 'package:maana_main_project_2/util/Helper.dart';
import 'package:maana_main_project_2/util/consts.dart';

class Dialogs {
  showExitDialog(BuildContext context) {
    bool isTablet = Helper.isTablet(context);
    showDialog(
      context: context,
      builder: (context) => CustomAlert(
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              SizedBox(height: 15.0),
              Text(
                Constants.appName,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: isTablet ? 23 : 16.0,
                ),
              ),
              SizedBox(height: 25.0),
              Text(
                'هل أنت متأكد من أنك تريد الخروج؟',
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: isTablet ? 20 : 14.0,
                ),
              ),
              SizedBox(height: isTablet ? 55 : 40.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                    height: 40.0,
                    width: 130.0,
                    child: OutlineButton(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      borderSide:
                          BorderSide(color: Theme.of(context).accentColor),
                      child: Text(
                        'كلا',
                        style: TextStyle(
                          color: Theme.of(context).accentColor,
                          fontSize: isTablet ? 23 : 16.0,
                        ),
                      ),
                      onPressed: () => Navigator.pop(context),
                      color: Colors.white,
                    ),
                  ),
                  Container(
                    height: 40.0,
                    width: 130.0,
                    child: RaisedButton(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      child: Text(
                        'نعم',
                        style: TextStyle(
                            fontSize: isTablet ? 23 : 16.0,
                            color: Theme.of(context).scaffoldBackgroundColor),
                      ),
                      onPressed: () => exit(0),
                      color: Theme.of(context).accentColor,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20.0),
            ],
          ),
        ),
      ),
    );
  }
}
