import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:quiver/strings.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:storeFlutter/models/identity/company-profile.dart';
import 'package:storeFlutter/models/identity/company.dart';
import 'package:storeFlutter/components/shopping/static-search-bar.dart';
import 'package:storeFlutter/components/shopping/shopping-cart-icon.dart';
import 'package:storeFlutter/components/shopping/seller-store/seller-store-header.dart';
import 'package:storeFlutter/components/shopping/seller-store/seller-store-body-nav.dart';
import 'package:storeFlutter/components/shopping/seller-store/seller-store-overview.dart';
import 'package:storeFlutter/components/app-button.dart';
import 'package:storeFlutter/components/app-html.dart';
import 'package:storeFlutter/components/app-label-value.dart';
import 'package:storeFlutter/components/app-list-title.dart';
import 'package:storeFlutter/components/app-panel.dart';
import 'package:storeFlutter/util/app-theme.dart';
import 'package:storeFlutter/util/resource-util.dart';
import 'package:storeFlutter/util/enums-util.dart';

class SellerStore extends StatefulWidget {
  final Company sellerCompany;
  final CompanyProfile sellerCompanyProfile;

  SellerStore(this.sellerCompany, this.sellerCompanyProfile);
  @override
  _SellerStoreState createState() => _SellerStoreState();
}

class _SellerStoreState extends State<SellerStore> {
  var activeChild = enumSelections.OVERVIEW;

  @override
  void initState() {
    print("Initialize SellerStore Screen and State");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.colorBg2,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(140),
        child: AppBar(
          title: Row(
            children: <Widget>[
              Expanded(
                child: StaticSearchBar(
                    placeholder: FlutterI18n.translate(
                        context, "shopping.searchProductSeller")),
              ),
            ],
          ),
          flexibleSpace: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: <Color>[AppTheme.colorPrimary, AppTheme.colorSuccess],
              ),
            ),
            child: SellerStoreHeader(widget.sellerCompany),
          ),
        ),
      ),
      body: sellerStoreBody(context),
    );
  }

  Widget sellerStoreBody(BuildContext context) {
    return (Column(children: <Widget>[
      SellerStoreBodyNav(_changeChild, activeChild),
      Expanded(
        child: Container(
          // padding: EdgeInsets.only(top: 20),
          child: sellerStoreBodyContent(context),
        ),
      ),
    ]));
  }

  Widget sellerStoreBodyContent(BuildContext context) {
    switch (activeChild) {
      case enumSelections.PRODUCTS:
        return SellerStoreOverview(
            widget.sellerCompany, widget.sellerCompanyProfile);
        break;
      case enumSelections.RATINGS:
        return (Container(child: Text("test2")));
        break;
      default:
        return SingleChildScrollView(
          child: SellerStoreOverview(
              widget.sellerCompany, widget.sellerCompanyProfile),
        );
        break;
    }
  }

  void _changeChild(enumSelections en) {
    print("Enum: $en");
    setState(() {
      activeChild = en;
    });
  }
}
