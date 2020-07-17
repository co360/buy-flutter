import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:storeFlutter/components/app-button.dart';
import 'package:storeFlutter/screens/shopping/product-listing.dart';
import 'package:storeFlutter/util/app-theme.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.colorBg2,
      appBar: AppBar(
        title: I18nText(
          "label.main",
          translationParams: {"user": "Yoke Harn"},
        ),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: <Color>[AppTheme.colorPrimary, AppTheme.colorSuccess],
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: <Widget>[
              AppButton(
                "Push Page Route",
                () => {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ProductListingScreen()))
                },
              ),
              AppButton(
                "Push Named Route",
                () => {
                  Navigator.pushNamed(context, '/listing'),
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
