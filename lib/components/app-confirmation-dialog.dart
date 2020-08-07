import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:storeFlutter/util/app-theme.dart';

class AppConfirmationDialog {
  final BuildContext context;
  final String title;
  final String content;
  final VoidCallback cb;
  final bool delete;

  BuildContext builderContext;

  AppConfirmationDialog(this.context,
      {this.title, this.content, this.cb, this.delete = false}) {
    if (Platform.isIOS) {
      _showDialogiOS();
    } else {
      _showDialogAndroid();
    }
  }

  _showDialogAndroid() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title == null
              ? FlutterI18n.translate(context, "general.confirm")
              : title),
          content: Text(content == null
              ? FlutterI18n.translate(context, "general.promptContinue")
              : content),
          actions: <Widget>[
            FlatButton(
              child: Text(
                FlutterI18n.translate(context, "general.cancel"),
                style: TextStyle(color: AppTheme.colorLink),
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            FlatButton(
              child: Text(
                delete
                    ? FlutterI18n.translate(context, "general.delete")
                    : FlutterI18n.translate(context, "general.ok"),
                style: TextStyle(
                  color: delete ? Colors.red : AppTheme.colorLink,
                  fontWeight: delete ? FontWeight.w500 : FontWeight.bold,
                ),
              ),
              onPressed: () {
                cb == null ? print("No action") : cb();
                Navigator.pop(context);
              },
            )
          ],
        );
      },
    );
  }

  _showDialogiOS() {
    showCupertinoDialog(
      context: context,
      builder: (BuildContext context) {
        return CupertinoAlertDialog(
          title: Text(title == null
              ? FlutterI18n.translate(context, "general.confirm")
              : title),
          content: Text(
            content == null
                ? FlutterI18n.translate(context, "general.promptContinue")
                : content,
            style: TextStyle(
              height: 1.3,
            ),
          ),
          actions: <Widget>[
            CupertinoDialogAction(
              child: Text(
                FlutterI18n.translate(context, "general.cancel"),
                style: TextStyle(color: AppTheme.colorLink),
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            CupertinoDialogAction(
              child: Text(
                delete
                    ? FlutterI18n.translate(context, "general.delete")
                    : FlutterI18n.translate(context, "general.ok"),
                style: TextStyle(
                  color: delete ? Colors.red : AppTheme.colorLink,
                  fontWeight: delete ? FontWeight.normal : FontWeight.bold,
                ),
              ),
              onPressed: () {
                cb == null ? print("No action") : cb();
                Navigator.pop(context);
              },
            )
          ],
        );
      },
    );
  }
}
