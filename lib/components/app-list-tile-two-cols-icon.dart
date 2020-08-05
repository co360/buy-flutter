import 'package:flutter/material.dart';
import 'package:storeFlutter/util/app-theme.dart';

class AppListTileTwoColsIcons extends StatelessWidget {
  final String titleLeft;
  final String titleRight;
  final String content;
  final String imagePath;
  final bool topDivider;
  final bool bottomDivider;

  AppListTileTwoColsIcons(this.titleLeft, this.titleRight, this.content,
      {this.topDivider: false, this.bottomDivider: true, this.imagePath});

  @override
  Widget build(BuildContext context) {
    List<Widget> widgets = [];

    widgets = <Widget>[
      ListTile(
        title: Padding(
          padding: EdgeInsets.only(top: 10.0),
          child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    imagePath == null
                        ? Container()
                        : Padding(
                            padding: EdgeInsets.only(
                              right: 10,
                            ),
                            child: Image.network(
                              imagePath,
                              fit: BoxFit.fill,
                              height: 20,
                              width: 40,
                            ),
                          ),
                    Text(titleLeft,
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 14)),
                  ],
                ),
                Text(titleRight,
                    style: TextStyle(
                        fontWeight: FontWeight.normal,
                        color: AppTheme.colorOrange,
                        fontSize: 14)),
              ]),
        ),
        subtitle: Padding(
            padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
            child: Text(content, style: TextStyle(fontSize: 14))),
      ),
      bottomDivider
          ? Divider(
              color: AppTheme.colorGray3,
              height: 1,
              thickness: 1,
            )
          : Container()
    ];

    if (topDivider) {
      widgets.insert(
        0,
        Divider(
          color: AppTheme.colorGray3,
          height: 1,
          thickness: 1,
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
