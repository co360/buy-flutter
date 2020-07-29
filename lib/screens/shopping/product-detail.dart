import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:quiver/strings.dart';
import 'package:storeFlutter/components/app-button.dart';
import 'package:storeFlutter/components/app-html.dart';
import 'package:storeFlutter/components/app-label-value.dart';
import 'package:storeFlutter/components/app-list-title.dart';
import 'package:storeFlutter/components/app-panel.dart';
import 'package:storeFlutter/components/shopping/product-detail/product-delivery-info.dart';
import 'package:storeFlutter/components/shopping/product-detail/product-image-slider.dart';
import 'package:storeFlutter/components/shopping/product-detail/product-variant.dart';
import 'package:storeFlutter/components/shopping/product-detail/seller-store-button.dart';
import 'package:storeFlutter/components/shopping/shopping-cart-icon.dart';
import 'package:storeFlutter/components/shopping/static-search-bar.dart';
import 'package:storeFlutter/models/identity/location.dart';
import 'package:storeFlutter/models/shopping/product.dart';
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
                () => showBottomSheet(context,
                    action: ProductActionModalAction.addToCart),
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
                () => showBottomSheet(context,
                    action: ProductActionModalAction.buyNow),
                size: AppButtonSize.small,
                noPadding: true,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void showBottomSheet(BuildContext context,
      {ProductActionModalAction action: ProductActionModalAction.both}) {
    showModalBottomSheet<void>(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      backgroundColor: Colors.white,
      builder: (BuildContext context) {
        return ProductActionModalBody(
          action: action,
        );
      },
    );
  }
}

class ProductActionModalBody extends StatelessWidget {
  final ProductActionModalAction action;

  const ProductActionModalBody({
    this.action = ProductActionModalAction.both,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print("action is $action");
    return SafeArea(
      child: Container(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(32.0),
              child: Text(
                'This is the modal bottom sheet. Slide down to dismiss.12',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Theme.of(context).accentColor,
                  fontSize: 24.0,
                ),
              ),
            ),
            buildActionButtons(context)
          ],
        ),
      ),
    );
  }

  Widget buildActionButtons(BuildContext context) {
    List<Widget> buttons = [];

    if (action == ProductActionModalAction.both ||
        action == ProductActionModalAction.addToCart) {
      buttons.add(
        Expanded(
          child: AppButton.widget(
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                FaIcon(
                  FontAwesomeIcons.lightShoppingCart,
                  color: Colors.white,
                  size: 16,
                ),
                SizedBox(width: 10),
                AutoSizeText(
                  FlutterI18n.translate(context, "shopping.addToCart"),
                  minFontSize: 7,
                  maxLines: 1,
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
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
      );
    }

    if (action == ProductActionModalAction.both) {
      buttons.add(
        SizedBox(
          width: 10,
        ),
      );
    }

    if (action == ProductActionModalAction.both ||
        action == ProductActionModalAction.buyNow) {
      buttons.add(
        Expanded(
          child: AppButton(
            FlutterI18n.translate(context, "shopping.buyNow"),
            () => {},
            size: AppButtonSize.small,
            noPadding: true,
          ),
        ),
      );
    }

    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 5.0,
      ),
      child: Row(
        children: buttons,
      ),
    );
  }
}

enum ProductActionModalAction { both, addToCart, buyNow }

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
            child: buildPanelContentWithAction(
                ProductDeliveryInfo(product), () => {}),
          ),
          ...buildProductOption(context),
          AppListTitle.noTopPadding(FlutterI18n.translate(
              context, "shopping.productDetail.productDetail")),
          AppPanel(
            children: <Widget>[
              buildProductDescription(context),
              buildProductSpecification(context),
              buildProductApplication(context),
              buildContactPerson(context),
            ],
          ),
          AppListTitle.noTopPadding(FlutterI18n.translate(
              context, "shopping.productDetail.keyProductAdvantage")),
          AppPanel(
            children: <Widget>[
              buildKeyProductAdvantage(context),
            ],
          ),
          AppListTitle.noTopPadding(FlutterI18n.translate(
              context, "shopping.productDetail.companyProfile")),
          AppPanel(
            children: <Widget>[
              buildCompanyIntroduction(context),
              buildCompanyBasicInformation(context),
            ],
          ),
          AppListTitle.noTopPadding(FlutterI18n.translate(
              context, "shopping.productDetail.ratingsReviews")),
          AppPanel(
            children: <Widget>[
              buildRatings(context),
              buildReviews(context),
            ],
          ),
        ],
      ),
    );
  }

  Widget buildProductDescription(BuildContext context) {
    if (isBlank(product.longDescription)) return null;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Text(
          FlutterI18n.translate(
              context, "shopping.productDetail.productDescription"),
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 10),
        AppHtml(product.longDescription),
      ],
    );
  }

  Widget buildProductApplication(BuildContext context) {
    if (isBlank(product.productApplication)) return null;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Text(
          FlutterI18n.translate(
              context, "shopping.productDetail.productApplication"),
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 10),
        AppHtml(product.productApplication),
      ],
    );
  }

  Widget buildProductSpecification(BuildContext context) {
    if (product.specificationValues == null ||
        product.specificationValues.length == 0) return null;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Text(
          FlutterI18n.translate(
              context, "shopping.productDetail.productSpecifications"),
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 10),
        ...product.specificationValues.expand((e) {
          return [
            Divider(
              color: AppTheme.colorGray3,
              height: 1,
              thickness: 1,
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 12.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    e.specification.name,
//                    style: TextStyle(fontSize: 17),
                  ),
                  Text(e.value + " " + e.specification.unit,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ))
                ],
              ),
            ),
          ];
        }).toList(),
      ],
    );
  }

  Widget buildContactPerson(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Text(
          FlutterI18n.translate(
              context, "shopping.productDetail.contactPerson"),
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 10),
//        Text(ResourceUtil.fullPathImageHtml(product.longDescription)),
      ],
    );
  }

  Widget buildKeyProductAdvantage(BuildContext context) {
    if (isBlank(product.keySellingPoint)) return null;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        AppHtml(product.keySellingPoint),
      ],
    );
  }

  Widget buildCompanyIntroduction(BuildContext context) {
    if (isBlank(product.sellerCompanyProfile.longIntroduction)) return null;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Text(
          FlutterI18n.translate(
              context, "shopping.productDetail.companyIntroduction"),
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 10),
        AppHtml(product.sellerCompanyProfile.longIntroduction),
      ],
    );
  }

  Widget buildCompanyBasicInformation(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Text(
          FlutterI18n.translate(
              context, "shopping.productDetail.basicInformation"),
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 10),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(
                child: AppLabelValue("Company", product.sellerCompany.name)),
            Expanded(child: AppLabelValue("Business Type", getBusinessType())),
          ],
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(child: AppLabelValue("Location", null)),
            Expanded(child: AppLabelValue("Total Employees", null)),
          ],
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(child: AppLabelValue("Year Registered", null)),
            Expanded(child: AppLabelValue("Total Annual Revenue", null)),
          ],
        ),
      ],
    );
  }

  Widget buildRatings(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Text(
          FlutterI18n.translate(context, "shopping.productDetail.ratings"),
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 10),
      ],
    );
  }

  Widget buildReviews(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Text(
          FlutterI18n.translate(context, "shopping.productDetail.reviews"),
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 10),
      ],
    );
  }

  String getBusinessType() {
    var formattedType = '';

    if (product.sellerCompany.businessType != null &&
        product.sellerCompany.businessType.length > 0) {
      product.sellerCompany.businessType.map((e) {});
    }
    return formattedType;
  }

  Widget buildPanelContentWithAction(Widget child, Function onPressed) {
    return GestureDetector(
      onTap: onPressed,
      behavior: HitTestBehavior.translucent,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(child: child),
          FaIcon(
            FontAwesomeIcons.lightChevronRight,
            size: 15,
          )
        ],
      ),
    );
  }

  List<Widget> buildProductOption(BuildContext context) {
    List<Widget> widgets = [];
    if (product.productType == ProductType.SKU && product.hasVariants) {
      widgets.add(
        AppListTitle.noTopPadding(
          FlutterI18n.translate(
              context, "shopping.productDetail.productOption"),
        ),
      );
      widgets.add(
        AppPanel(
          child: buildPanelContentWithAction(
              ProductVariant(product), () => {showBottomSheet(context)}),
        ),
      );
    }

    return widgets;
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

  void showBottomSheet(BuildContext context,
      {ProductActionModalAction action: ProductActionModalAction.both}) {
    showModalBottomSheet<void>(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      backgroundColor: Colors.white,
      builder: (BuildContext context) {
        return ProductActionModalBody(
          action: action,
        );
      },
    );
  }
}

class ProductDetailScreenParams {
  final Product product;

  ProductDetailScreenParams({this.product});
}
