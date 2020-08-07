import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:storeFlutter/components/shopping/seller-store/seller-store-search.dart';
import 'package:storeFlutter/models/identity/company-profile.dart';
import 'package:storeFlutter/models/identity/company.dart';
import 'package:storeFlutter/models/filter-type.dart';
import 'package:storeFlutter/blocs/shopping/product-listing-bloc.dart';
import 'package:storeFlutter/components/shopping/seller-store/seller-store-header.dart';
import 'package:storeFlutter/components/shopping/seller-store/seller-store-overview.dart';
import 'package:storeFlutter/components/shopping/seller-store/seller-store-products.dart';
import 'package:storeFlutter/components/shopping/seller-store/seller-store-review.dart';
import 'package:storeFlutter/util/app-theme.dart';
import 'package:storeFlutter/util/enums-util.dart';
import 'package:storeFlutter/services/product-service.dart';

class SellerStore extends StatefulWidget {
  final Company sellerCompany;
  final CompanyProfile sellerCompanyProfile;

  SellerStore(this.sellerCompany, this.sellerCompanyProfile);
  @override
  _SellerStoreState createState() => _SellerStoreState();
}

class _SellerStoreState extends State<SellerStore>
    with SingleTickerProviderStateMixin {
  var activeChild = enumSellerStore.OVERVIEW;
  TabController _tabController;

  @override
  void initState() {
    print("Initialize SellerStore Screen and State");
    super.initState();
    _tabController = TabController(vsync: this, length: 3);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Map<String, FilterValue> filter = {
      "companyId": FilterValue(widget.sellerCompany.id.toString(),
          widget.sellerCompany.id.toString(), 0)
    };
    return BlocProvider<ProductListingBloc>(
      create: (context) => ProductListingBloc()
        ..add(ProductListingSearch(
            context,
            ProductListingQueryFilter(
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
              SellerStoreSearch(),
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
          iconTheme: IconThemeData(color: Colors.white),
        ),
      ),
      body: sellerStoreBody(context),
    );
  }

  Widget sellerStoreBody(BuildContext context) {
    return (Column(children: <Widget>[
      Container(
        color: Colors.white,
        child: TabBar(
          controller: _tabController,
          isScrollable: true,
          unselectedLabelColor: Colors.black,
          labelColor: AppTheme.colorOrange,
          indicatorWeight: 2,
          indicatorColor: AppTheme.colorOrange,
          unselectedLabelStyle: TextStyle(fontWeight: FontWeight.normal),
          tabs: <Widget>[
            Tab(
              text: FlutterI18n.translate(
                  context, "shopping.sellerStorePage.overview"),
            ),
            Tab(
              text: FlutterI18n.translate(
                  context, "shopping.sellerStorePage.products"),
            ),
            Tab(
              text: FlutterI18n.translate(
                  context, "shopping.sellerStorePage.ratings"),
            )
          ],
        ),
      ),
      Expanded(
        child: Container(
          child: TabBarView(
            physics: BouncingScrollPhysics(),
            controller: _tabController,
            children: <Widget>[
              SingleChildScrollView(
                child: SellerStoreOverview(
                    widget.sellerCompany, widget.sellerCompanyProfile),
              ),
              SellerStoreProducts(
                  widget.sellerCompany, widget.sellerCompanyProfile),
              SingleChildScrollView(
                child: SellerStoreReview(
                    widget.sellerCompany, widget.sellerCompanyProfile),
              ),
            ],
          ),
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
        return SingleChildScrollView(
          child: SellerStoreReview(
              widget.sellerCompany, widget.sellerCompanyProfile),
        );
        break;
      default:
        return SingleChildScrollView(
          child: SellerStoreOverview(
              widget.sellerCompany, widget.sellerCompanyProfile),
        );
        break;
    }
  }
}
