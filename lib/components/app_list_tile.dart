import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:storeFlutter/util/app-theme.dart';

class AppListTile extends StatelessWidget {
  final VoidCallback onTap;
  final String title;
  final bool topDivider;

  AppListTile(this.title, {this.onTap, this.topDivider: false});

  @override
  Widget build(BuildContext context) {
    List<Widget> widgets = [];

    widgets = <Widget>[
      ListTile(
        onTap: onTap,
        trailing: FaIcon(
          FontAwesomeIcons.lightChevronRight,
          size: 20,
          color: Colors.black,
        ),
        title: I18nText(title),
      ),
      Divider(
        color: AppTheme.colorGray3,
        height: 1,
      )
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
