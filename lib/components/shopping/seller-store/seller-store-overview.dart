import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:quiver/strings.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:storeFlutter/components/app-list-tile-two-cols.dart';
import 'package:storeFlutter/models/identity/company-profile.dart';
import 'package:storeFlutter/models/identity/company.dart';
import 'package:storeFlutter/components/app-html.dart';
import 'package:storeFlutter/components/app-list-title.dart';
import 'package:storeFlutter/components/app-panel.dart';

class SellerStoreOverview extends StatelessWidget {
  final Company sellerCompany;
  final CompanyProfile sellerCompanyProfile;

  const SellerStoreOverview(
    this.sellerCompany,
    this.sellerCompanyProfile, {
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        SizedBox(height: 20),
        AppListTitle.noTopPadding(
          FlutterI18n.translate(context, "shopping.sellerStorePage.intro"),
        ),
        AppPanel(
          children: <Widget>[
            buildCompanyIntroduction(context),
          ],
        ),
        AppListTitle.noTopPadding(
            FlutterI18n.translate(context, "shopping.sellerStorePage.basic")),
        Container(
          color: Colors.white,
          child: buildCompanyBasicInformation(context),
        )
      ],
    );
  }

  Widget buildCompanyIntroduction(BuildContext context) {
    if (isBlank(sellerCompanyProfile.longIntroduction)) return null;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        SizedBox(height: 10),
        AppHtml(sellerCompanyProfile.longIntroduction),
      ],
    );
  }

  Widget buildCompanyBasicInformation(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        AppListTileTwoCols(
            FlutterI18n.translate(
                context, "shopping.sellerStorePage.businessType"),
            sellerCompany.businessType == null ||
                    sellerCompany.businessType.length == 0
                ? "-"
                : sellerCompany.businessType[0]),
        AppListTileTwoCols(
            FlutterI18n.translate(context, "shopping.sellerStorePage.location"),
            sellerCompany.address1 == null
                ? ""
                : (sellerCompany.address1 +
                    (sellerCompany.countryName == null
                        ? ""
                        : ", " + sellerCompany.countryName))),
        AppListTileTwoCols(
            FlutterI18n.translate(
                context, "shopping.sellerStorePage.totalEmployees"),
            sellerCompany.totalEmployees == null
                ? "-"
                : sellerCompany.totalEmployees),
        AppListTileTwoCols(
            FlutterI18n.translate(
                context, "shopping.sellerStorePage.yearRegistered"),
            sellerCompany.yearRegistered == null
                ? "-"
                : sellerCompany.yearRegistered),
        AppListTileTwoCols(
            FlutterI18n.translate(
                context, "shopping.sellerStorePage.totalAnnualRevenue"),
            "-"),
      ],
    );
  }

  String getBusinessType() {
    var formattedType = '';

    if (sellerCompany.businessType != null &&
        sellerCompany.businessType.length > 0) {
      sellerCompany.businessType.map((e) {});
    }
    return formattedType;
  }
}
