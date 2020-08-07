import 'package:flutter/material.dart';
import 'package:storeFlutter/util/app-theme.dart';

class AppLoading extends StatelessWidget {
  final EdgeInsets padding;
  final double size;
  final double strokeWidth;

  AppLoading(
      {this.padding = const EdgeInsets.all(20),
      this.size = 30,
      this.strokeWidth = 3});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Center(
            child: SizedBox(
              height: size,
              width: size,
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(AppTheme.colorOrange),
                strokeWidth: strokeWidth,
              ),
            ),
          )
        ],
      ),
    );
  }
}
