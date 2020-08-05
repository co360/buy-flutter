import 'package:flutter/material.dart';
import 'package:storeFlutter/util/app-theme.dart';

class AppListTitle extends StatelessWidget {
  final String title;
  final EdgeInsets padding;
  final double size;

  AppListTitle(this.title, {this.padding, this.size = 17});
  AppListTitle.noTopPadding(this.title,
      {this.padding = const EdgeInsets.only(
        top: 0,
        left: AppTheme.paddingStandard,
        right: AppTheme.paddingStandard,
        bottom: AppTheme.paddingStandard,
      ),
      this.size = 17});

  @override
  Widget build(BuildContext context) {
    EdgeInsets padding = this.padding != null
        ? this.padding
        : EdgeInsets.all(AppTheme.paddingStandard);
    return Padding(
      padding: padding,
      child: Text(title,
          style: TextStyle(fontSize: size, fontWeight: FontWeight.bold)),
    );
  }
}
