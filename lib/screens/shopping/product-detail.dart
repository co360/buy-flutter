import 'package:auto_size_text/auto_size_text.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:quiver/strings.dart';
import 'package:storeFlutter/components/app-button.dart';
import 'package:storeFlutter/components/app-list-title.dart';
import 'package:storeFlutter/components/app-panel.dart';
import 'package:storeFlutter/components/shopping/shopping-cart-icon.dart';
import 'package:storeFlutter/components/shopping/static-search-bar.dart';
import 'package:storeFlutter/models/identity/company-profile.dart';
import 'package:storeFlutter/models/identity/company.dart';
import 'package:storeFlutter/models/identity/location.dart';
import 'package:storeFlutter/models/shopping/product.dart';
import 'package:storeFlutter/screens/shopping/seller-store.dart';
import 'package:storeFlutter/util/app-theme.dart';
import 'package:storeFlutter/util/format-util.dart';
import 'package:storeFlutter/util/resource-util.dart';

class ProductDetailScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final ProductDetailScreenParams args =
        ModalRoute.of(context).settings.arguments;

    Product product = args.product;

    return Scaffold(
      backgroundColor: AppTheme.colorBg2,
      appBar: AppBar(
        titleSpacing: 0,
        title: Row(
          children: <Widget>[
            Expanded(
              child: StaticSearchBar(
                placeholder: FlutterI18n.translate(
                  context,
                  "shopping.searchProductSeller",
                ),
                borderColor: AppTheme.colorOrange,
              ),
            ),
            SizedBox(width: 10),
            ShoppingCartIcon(
              dark: true,
            ),
            SizedBox(width: 10),
          ],
        ),
//        flexibleSpace: Container(
//          decoration: BoxDecoration(
//            gradient: LinearGradient(
//              begin: Alignment.topLeft,
//              end: Alignment.bottomRight,
//              colors: <Color>[AppTheme.colorPrimary, AppTheme.colorSuccess],
//            ),
//          ),
//        ),
//        iconTheme: IconThemeData(color: Colors.white),
      ),
      bottomNavigationBar: buildBottomAppBar(product, context),
      body: ProductDetailBody(product),
    );
  }

  BottomAppBar buildBottomAppBar(Product product, BuildContext context) {
    return BottomAppBar(
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 10,
          vertical: 5.0,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            SellerStoreButton(
                product.sellerCompany, product.sellerCompanyProfile),
            SizedBox(
              width: 10,
            ),
            Expanded(
              child: AppButton.widget(
                Row(
                  children: <Widget>[
                    FaIcon(
                      FontAwesomeIcons.lightShoppingCart,
                      color: Colors.white,
                      size: 16,
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: AutoSizeText(
                        FlutterI18n.translate(context, "shopping.addToCart"),
                        minFontSize: 7,
                        maxLines: 1,
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    )
                  ],
                ),
                () => {},
                size: AppButtonSize.small,
                type: AppButtonType.success,
                noPadding: true,
              ),
            ),
            SizedBox(
              width: 10,
            ),
            Expanded(
              child: AppButton(
                FlutterI18n.translate(context, "shopping.buyNow"),
                () => showBottomSheet(context),
                size: AppButtonSize.small,
                noPadding: true,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void showBottomSheet(BuildContext context) {
    showModalBottomSheet<void>(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      backgroundColor: Colors.white,
      builder: (BuildContext context) {
        return Container(
          child: Padding(
            padding: const EdgeInsets.all(32.0),
            child: Text(
              'This is the modal bottom sheet. Slide down to dismiss.',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Theme.of(context).accentColor,
                fontSize: 24.0,
              ),
            ),
          ),
        );
      },
    );
  }
}

class ProductDetailBody extends StatelessWidget {
  final Product product;

  const ProductDetailBody(
    this.product, {
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          ProductImageSlider(product),
          buildBasicProductInfoPanel(),
          AppListTitle.noTopPadding(FlutterI18n.translate(
              context, "shopping.productDetail.delivery")),
          AppPanel(
            child: Text("delivery info"),
          ),
          AppListTitle.noTopPadding(FlutterI18n.translate(
              context, "shopping.productDetail.productOption")),
          AppPanel(
            child: Text("delivery info"),
          ),
          AppListTitle.noTopPadding(FlutterI18n.translate(
              context, "shopping.productDetail.productDetail")),
          AppPanel(
            children: <Widget>[
              Text("abc"),
              Text("abc"),
              Text("abc"),
              Text("abc"),
              Text("abc"),
              Text("abc"),
              Text("abc"),
              Text("abc"),
              Text("abc"),
              Text("abc"),
              Text("abc"),
            ],
          ),
        ],
      ),
    );
  }

  AppPanel buildBasicProductInfoPanel() {
    return AppPanel(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Text(
            product.name,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          ...(product.consumerPrice > 0)
              ? [
                  Text(
                    "${product.consumerPriceCurrency} ${FormatUtil.formatPrice(product.consumerPrice)}",
                    style: TextStyle(
                      fontSize: 19,
                      color: AppTheme.colorOrange,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 10),
                ]
              : [SizedBox.shrink()],
          Row(
            children: <Widget>[
              getSellerLogo(),
              Expanded(
                child: Text(
                  product.sellerCompany.name,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
//                          color: AppTheme.colorGray6,
//                          fontSize: 16,
                      ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            getLocationInfo(),
            style: TextStyle(
              color: AppTheme.colorPrimary,
            ),
          )
        ],
      ),
    );
  }

  Widget getSellerLogo() {
    if (product.sellerCompany != null && product.sellerCompany.image != null) {
      return Padding(
        padding: EdgeInsets.only(right: 10),
        child: SizedBox(
          width: 30,
          child: Container(
            child: Image.network(
              ResourceUtil.fullPath(product.sellerCompany.image.imageUrl),
              fit: BoxFit.cover,
//          width: MediaQuery.of(context).size.width,
            ),
          ),
        ),
      );
    } else {
      return Container();
    }
  }

  String getLocationInfo() {
    String locationInfo;

    if (product.sellerCompanyProfile != null) {
      Location location = product.sellerCompanyProfile.locations
          .firstWhere((element) => element.supplyLocation);

      if (location != null) {
        if (isBlank(locationInfo))
          locationInfo = location.city +
              (isBlank(location.state) ? '' : ', ' + location.state);
        if (isBlank(locationInfo)) locationInfo = location.countryName;
      }
    }

    if (isBlank(locationInfo)) {
      if (product.sellerCompany != null) {
        if (isBlank(locationInfo)) locationInfo = product.sellerCompany.city;
        if (isBlank(locationInfo))
          locationInfo = product.sellerCompany.countryName;
      }
    }

    return locationInfo;
  }
}

class ProductImageSlider extends StatefulWidget {
  final Product product;

  ProductImageSlider(this.product);

  @override
  _ProductImageSliderState createState() => _ProductImageSliderState();
}

class _ProductImageSliderState extends State<ProductImageSlider> {
  int _current = 0;

  List<Widget> imageSliders(BuildContext context) {
    return widget.product.images
        .map(
          (img) => Container(
            child: Image.network(
              ResourceUtil.fullPath(img.imageUrl),
              fit: BoxFit.cover,
              width: MediaQuery.of(context).size.width,
            ),
          ),
        )
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.topCenter,
      children: <Widget>[
        CarouselSlider(
          options: CarouselOptions(
            aspectRatio: 1,
            autoPlay: false,
            viewportFraction: 1,
            enableInfiniteScroll: false,
            onPageChanged: (index, reason) {
              setState(() {
                _current = index;
              });
            },
          ),
          items: imageSliders(context),
        ),
        Positioned(
          bottom: 10,
          right: 10,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.6),
              borderRadius: BorderRadius.all(Radius.circular(30)),
//              shape: BoxShape.circle,
            ),
            padding: EdgeInsets.all(8),
            child: Text(
              "${_current + 1}/${widget.product.images.length}",
              style: TextStyle(
                color: Colors.white,
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class SellerStoreButton extends StatelessWidget {
  final Company sellerCompany;
  final CompanyProfile sellerCompanyProfile;

  const SellerStoreButton(
    this.sellerCompany,
    this.sellerCompanyProfile, {
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          CupertinoPageRoute(
              builder: (context) =>
                  SellerStore(sellerCompany, sellerCompanyProfile)),
        );
      },
//      child: FaIcon(
//        FontAwesomeIcons.lightStore,
//        size: 16,
//      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          FaIcon(
            FontAwesomeIcons.lightStore,
            size: 16,
          ),
          SizedBox(
            height: 5,
          ),
          Text(
            FlutterI18n.translate(context, "shopping.sellerStore"),
            style: TextStyle(fontSize: 10, fontWeight: FontWeight.w500),
          )
        ],
      ),
    );
  }
}

class ProductDetailScreenParams {
  final Product product;

  ProductDetailScreenParams({this.product});
}
