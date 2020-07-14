import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:storeFlutter/util/app-theme.dart';

class AppListTitle extends StatelessWidget {
  final String title;

  AppListTitle(this.title);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(AppTheme.paddingStandard),
      child: I18nText(
        title,
        child: Text("dummy",
            style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold)),
      ),
    );
  }
}
