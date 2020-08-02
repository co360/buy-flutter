import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:storeFlutter/util/app-theme.dart';

class AppAlertDialog {
  final BuildContext context;
  final String title;
  final String content;
  final VoidCallback cb;

  BuildContext builderContext;

  AppAlertDialog(this.context, {this.title, this.content, this.cb}) {
    _showDialog();
  }

  _showDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title == null ? "Test Title" : title),
          content: Text(content == null ? "Test Content" : content),
          actions: <Widget>[
            FlatButton(
              child: Text("OK"),
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
