import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:storeFlutter/components/app-button.dart';
import 'package:storeFlutter/util/app-theme.dart';

class ProductListingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final ProductListingScreenParams args =
        ModalRoute.of(context).settings.arguments;
    String query = args.query;

    return Scaffold(
      backgroundColor: AppTheme.colorBg2,
      appBar: AppBar(
        title: I18nText("shopping.productListing"),
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
              Text("param $query"),
              AppButton(
                "Go To Detail",
                () => {
                  Navigator.pushNamed(context, '/detail'),
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}

class ProductListingScreenParams {
  final String query;

  ProductListingScreenParams({this.query});
}
