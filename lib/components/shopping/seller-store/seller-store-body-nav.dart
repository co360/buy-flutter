import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:storeFlutter/util/app-theme.dart';
import 'package:storeFlutter/util/enums-util.dart';

class SellerStoreBodyNav extends StatelessWidget {
  final Function(enumSellerStore) cb;
  final enumSellerStore active;

  const SellerStoreBodyNav(
    this.cb,
    this.active, {
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 2,
                  blurRadius: 4,
                  offset: Offset(0, 3), // changes position of shadow
                ),
              ],
            ),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.30,
                    child: FlatButton(
                      textColor: Colors.black,
                      onPressed: () => cb(enumSellerStore.OVERVIEW),
                      child: Text(
                        FlutterI18n.translate(
                            context, "shopping.sellerStorePage.overview"),
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: active == enumSellerStore.OVERVIEW
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
                      onPressed: () => cb(enumSellerStore.PRODUCTS),
                      child: Text(
                        FlutterI18n.translate(
                            context, "shopping.sellerStorePage.products"),
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: active == enumSellerStore.PRODUCTS
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
                      onPressed: () => cb(enumSellerStore.RATINGS),
                      child: Text(
                        FlutterI18n.translate(
                            context, "shopping.sellerStorePage.ratings"),
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: active == enumSellerStore.RATINGS
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
