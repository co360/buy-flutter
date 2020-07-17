import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:storeFlutter/components/app-button.dart';
import 'package:storeFlutter/util/app-theme.dart';

class ProductDetailScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.colorBg2,
      appBar: AppBar(
        title: I18nText("shopping.productDetail.name"),
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
                "Go To Listing",
                () => {
                  Navigator.pushNamed(context, '/listing'),
                },
              ),
              AppButton(
                "Pop all to cart",
                () => {
//                  Navigator.popAndPushNamed(context, '/cart'),
                  Navigator.of(context).popUntil((route) => route.isFirst),
                },
                type: AppButtonType.white,
              )
            ],
          ),
        ),
      ),
    );
  }
}
