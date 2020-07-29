import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:storeFlutter/util/app-theme.dart';

class AppListTileTwoCols extends StatelessWidget {
  final String title;
  final String content;
  final bool topDivider;
  final bool bottomDivider;

  AppListTileTwoCols(this.title, this.content,
      {this.topDivider: false, this.bottomDivider: true});

  @override
  Widget build(BuildContext context) {
    List<Widget> widgets = [];

    widgets = <Widget>[
      ListTile(
        title: Padding(
            padding: EdgeInsets.only(top: 10.0),
            child: Text(title,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15))),
        subtitle: Padding(
            padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
            child: Text(content, style: TextStyle(fontSize: 15))),
      ),
      bottomDivider
          ? Divider(
              color: AppTheme.colorGray3,
              height: 1,
            )
          : Container()
    ];

    if (topDivider) {
      widgets.insert(
        0,
        Divider(
          color: AppTheme.colorGray3,
          height: 1,
        ),
      );
    }

    return Container(
      color: Colors.white,
      child: Column(
        children: widgets,
      ),
    );
  }
}
