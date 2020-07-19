import 'package:flutter/material.dart';
import 'package:storeFlutter/util/app-theme.dart';

class AppListTitle extends StatelessWidget {
  final String title;

  AppListTitle(this.title);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(AppTheme.paddingStandard),
      child: Text(title,
          style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold)),
    );
  }
}
