import 'package:flutter/material.dart';
import 'package:storeFlutter/util/app-theme.dart';

class AppLoading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(AppTheme.paddingStandard),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Center(
            child: SizedBox(
              height: 30,
              width: 30,
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(AppTheme.colorOrange),
                strokeWidth: 3,
              ),
            ),
          )
        ],
      ),
    );
  }
}
