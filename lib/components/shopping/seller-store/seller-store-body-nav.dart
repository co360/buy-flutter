import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:storeFlutter/screens/shopping/seller-store.dart';
import 'package:storeFlutter/util/app-theme.dart';
import 'package:storeFlutter/util/enums-util.dart';

class SellerStoreBodyNav extends StatelessWidget {
  final Function(enumSelections) cb;
  final enumSelections active;

  const SellerStoreBodyNav(
    this.cb,
    this.active, {
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Container(
            color: Colors.white,
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.30,
                    child: FlatButton(
                      textColor: Colors.black,
                      onPressed: () => cb(enumSelections.OVERVIEW),
                      child: Text(
                        FlutterI18n.translate(
                            context, "shopping.sellerStorePage.overview"),
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: active == enumSelections.OVERVIEW
                                ? AppTheme.colorOrange
                                : Colors.black,
                            fontSize: 14),
                      ),
                      shape: CircleBorder(
                          side: BorderSide(color: Colors.transparent)),
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.30,
                    child: FlatButton(
                      textColor: Colors.black,
                      onPressed: () => cb(enumSelections.PRODUCTS),
                      child: Text(
                        FlutterI18n.translate(
                            context, "shopping.sellerStorePage.products"),
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: active == enumSelections.PRODUCTS
                                ? AppTheme.colorOrange
                                : Colors.black,
                            fontSize: 14),
                      ),
                      shape: CircleBorder(
                          side: BorderSide(color: Colors.transparent)),
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.30,
                    child: FlatButton(
                      textColor: Colors.black,
                      onPressed: () => cb(enumSelections.RATINGS),
                      child: Text(
                        FlutterI18n.translate(
                            context, "shopping.sellerStorePage.ratings"),
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: active == enumSelections.RATINGS
                                ? AppTheme.colorOrange
                                : Colors.black,
                            fontSize: 14),
                      ),
                      shape: CircleBorder(
                          side: BorderSide(color: Colors.transparent)),
                    ),
                  ),
                ])));
  }
}
