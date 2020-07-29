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

class SellerStoreProducts extends StatelessWidget {
  final Company sellerCompany;
  final CompanyProfile sellerCompanyProfile;

  const SellerStoreProducts(
    this.sellerCompany,
    this.sellerCompanyProfile, {
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
