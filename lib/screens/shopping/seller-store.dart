import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:quiver/strings.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:storeFlutter/models/identity/company-profile.dart';
import 'package:storeFlutter/models/identity/company.dart';
import 'package:storeFlutter/models/filter-type.dart';
import 'package:storeFlutter/blocs/shopping/product-listing-bloc.dart';
import 'package:storeFlutter/components/shopping/static-search-bar.dart';
import 'package:storeFlutter/components/shopping/shopping-cart-icon.dart';
import 'package:storeFlutter/components/shopping/seller-store/seller-store-header.dart';
import 'package:storeFlutter/components/shopping/seller-store/seller-store-body-nav.dart';
import 'package:storeFlutter/components/shopping/seller-store/seller-store-overview.dart';
import 'package:storeFlutter/components/shopping/seller-store/seller-store-products.dart';
import 'package:storeFlutter/components/shopping/seller-store/seller-store-review.dart';
import 'package:storeFlutter/components/app-button.dart';
import 'package:storeFlutter/components/app-html.dart';
import 'package:storeFlutter/components/app-label-value.dart';
import 'package:storeFlutter/components/app-list-title.dart';
import 'package:storeFlutter/components/app-panel.dart';
import 'package:storeFlutter/util/app-theme.dart';
import 'package:storeFlutter/util/resource-util.dart';
import 'package:storeFlutter/util/enums-util.dart';
import 'package:storeFlutter/services/product-service.dart';

class SellerStore extends StatefulWidget {
  final Company sellerCompany;
  final CompanyProfile sellerCompanyProfile;

  SellerStore(this.sellerCompany, this.sellerCompanyProfile);
  @override
  _SellerStoreState createState() => _SellerStoreState();
}

class _SellerStoreState extends State<SellerStore> {
  var activeChild = enumSellerStore.OVERVIEW;

  @override
  void initState() {
    print("Initialize SellerStore Screen and State");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Map<String, FilterValue> filter = {
      "companyId": FilterValue(widget.sellerCompany.id.toString(),
          widget.sellerCompany.id.toString(), 0)
    };
    return BlocProvider<ProductListingBloc>(
      create: (context) => ProductListingBloc()
        ..add(ProductListingSearch(ProductListingQueryFilter(
            query: "", filters: filter != null ? filter : {}))),
      child: Builder(builder: (context) {
        return buildChild(context);
      }),
    );
  }

  Widget buildChild(BuildContext context) {
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
      case enumSellerStore.PRODUCTS:
        return SellerStoreProducts(
            widget.sellerCompany, widget.sellerCompanyProfile);
        break;
      case enumSellerStore.RATINGS:
        return SellerStoreReview(
            widget.sellerCompany, widget.sellerCompanyProfile);
        break;
      default:
        return SingleChildScrollView(
          child: SellerStoreOverview(
              widget.sellerCompany, widget.sellerCompanyProfile),
        );
        break;
    }
  }

  void _changeChild(enumSellerStore en) {
    print("Enum: $en");
    setState(() {
      activeChild = en;
    });
  }
}
