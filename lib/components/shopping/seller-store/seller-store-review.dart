import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:quiver/strings.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:storeFlutter/components/app-list-tile-two-cols.dart';
import 'package:storeFlutter/models/identity/company-profile.dart';
import 'package:storeFlutter/models/identity/company.dart';
import 'package:storeFlutter/components/shopping/static-search-bar.dart';
import 'package:storeFlutter/components/shopping/shopping-cart-icon.dart';
import 'package:storeFlutter/components/shopping/seller-store/seller-store-header.dart';
import 'package:storeFlutter/components/shopping/seller-store/seller-store-body-nav.dart';
import 'package:storeFlutter/components/app-button.dart';
import 'package:storeFlutter/components/app-html.dart';
import 'package:storeFlutter/components/app-label-value.dart';
import 'package:storeFlutter/components/app-list-title.dart';
import 'package:storeFlutter/components/app-panel.dart';
import 'package:storeFlutter/util/app-theme.dart';
import 'package:storeFlutter/util/resource-util.dart';
import 'package:storeFlutter/util/enums-util.dart';

class SellerStoreReview extends StatelessWidget {
  final Company sellerCompany;
  final CompanyProfile sellerCompanyProfile;

  const SellerStoreReview(
    this.sellerCompany,
    this.sellerCompanyProfile, {
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        SizedBox(height: 20),
        Align(
          alignment: Alignment.center,
          child: AppListTitle.noTopPadding(FlutterI18n.translate(
              context, "shopping.sellerStorePage.overallRatings")),
        ),
        Container(
            color: Colors.white,
            padding: EdgeInsets.only(top: 20, bottom: 20, right: 5, left: 5),
            child: ratingBody(context)),
        SizedBox(height: 15),
        Align(
          alignment: Alignment.centerLeft,
          child: AppListTitle.noTopPadding(FlutterI18n.translate(
              context, "shopping.sellerStorePage.reviewsLabel")),
        ),
        Container(
          color: Colors.white,
          padding: EdgeInsets.only(top: 20, bottom: 20, right: 5, left: 5),
          child: dynamicReviewBody(context),
        ),
      ],
    ));
  }

  Widget ratingBody(BuildContext context) {
    return (Column(children: <Widget>[
      Text(
        "4.5",
        textAlign: TextAlign.center,
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 34),
      ),
      SizedBox(height: 10),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          FaDuotoneIcon(
            FontAwesomeIcons.duotoneStar,
            secondaryColor: AppTheme.colorYellow,
            primaryColor: AppTheme.colorYellow,
            size: 30,
          ),
          FaDuotoneIcon(
            FontAwesomeIcons.duotoneStar,
            secondaryColor: AppTheme.colorYellow,
            primaryColor: AppTheme.colorYellow,
            size: 30,
          ),
          FaDuotoneIcon(
            FontAwesomeIcons.duotoneStar,
            secondaryColor: Colors.white,
            primaryColor: AppTheme.colorYellow,
            size: 30,
          ),
          FaDuotoneIcon(
            FontAwesomeIcons.duotoneStar,
            secondaryColor: Colors.white,
            primaryColor: AppTheme.colorYellow,
            size: 30,
          ),
          FaDuotoneIcon(
            FontAwesomeIcons.duotoneStar,
            secondaryColor: Colors.white,
            primaryColor: AppTheme.colorYellow,
            size: 30,
          ),
        ],
      ),
      SizedBox(height: 15),
      Text(
        "24" +
            " " +
            FlutterI18n.translate(
                context, "shopping.sellerStorePage.ratingsLabel"),
        textAlign: TextAlign.center,
        style: TextStyle(fontWeight: FontWeight.normal, fontSize: 14),
      ),
    ]));
  }

  Widget dynamicReviewBody(BuildContext context) {
    return (Column(children: <Widget>[
      Text(FlutterI18n.translate(
          context, "shopping.sellerStorePage.noReviewsYet")),
    ]));
  }
}
