import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:quiver/strings.dart';
import 'package:storeFlutter/blocs/shopping/product-detail-bloc.dart';
import 'package:storeFlutter/components/account/check-session.dart';
import 'package:storeFlutter/components/app-button.dart';
import 'package:storeFlutter/components/app-html.dart';
import 'package:storeFlutter/components/app-label-value.dart';
import 'package:storeFlutter/components/app-list-title.dart';
import 'package:storeFlutter/components/app-panel.dart';
import 'package:storeFlutter/components/form/quantity-input.dart';
import 'package:storeFlutter/components/shopping/product-detail/product-delivery-info.dart';
import 'package:storeFlutter/components/shopping/product-detail/product-image-slider.dart';
import 'package:storeFlutter/components/shopping/product-detail/product-review.dart';
import 'package:storeFlutter/components/shopping/product-detail/product-variant.dart';
import 'package:storeFlutter/components/shopping/product-detail/seller-store-button.dart';
import 'package:storeFlutter/components/shopping/product-detail/product-rating.dart';
import 'package:storeFlutter/components/shopping/shopping-cart-icon.dart';
import 'package:storeFlutter/components/shopping/static-search-bar.dart';
import 'package:storeFlutter/datasource/data-source-helper.dart';
import 'package:storeFlutter/models/identity/company-profile.dart';
import 'package:storeFlutter/models/identity/company.dart';
import 'package:storeFlutter/models/identity/location.dart';
import 'package:storeFlutter/models/shopping/product.dart';
import 'package:storeFlutter/util/app-theme.dart';
import 'package:storeFlutter/util/format-util.dart';
import 'package:storeFlutter/util/resource-util.dart';
import 'package:storeFlutter/util/enums-util.dart';

class ProductDetailScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final ProductDetailScreenParams args =
        ModalRoute.of(context).settings.arguments;

    Product product = args.product;

    return BlocProvider(
      create: (context) =>
          ProductDetailBloc(product: product, buildContext: context),
      child: Builder(
        builder: (context) {
          return BlocBuilder<ProductDetailBloc, ProductDetailState>(
            buildWhen: (previousState, state) {
              return (state is ProductDetailLoadComplete ||
                  state is ProductDetailInitial);
            },
            builder: (context, state) {
              ProductDetailBloc bloc =
                  BlocProvider.of<ProductDetailBloc>(context);

              var sellerCompanyProfile = bloc.sellerCompanyProfile;
              var sellerCompany = bloc.sellerCompany;

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
                ),
                bottomNavigationBar: buildBottomAppBar(
                    product, sellerCompany, sellerCompanyProfile, context),
                body: ProductDetailBody(
                    product, sellerCompany, sellerCompanyProfile),
              );
            },
          );
        },
      ),
    );
  }

  BottomAppBar buildBottomAppBar(Product product, Company sellerCompany,
      CompanyProfile sellerCompanyProfile, BuildContext context) {
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
            SellerStoreButton(sellerCompany, sellerCompanyProfile),
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
                () => CheckSession.checkSession(
                  context,
                  () {
                    ProductDetailScreen.showProductDetailBottomSheet(
                        context, product,
                        action: ProductActionModalAction.addToCart);
                  },
                ),
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
                () => CheckSession.checkSession(
                  context,
                  () {
                    ProductDetailScreen.showProductDetailBottomSheet(
                        context, product,
                        action: ProductActionModalAction.buyNow);
                  },
                ),
                size: AppButtonSize.small,
                noPadding: true,
              ),
            ),
          ],
        ),
      ),
    );
  }

  static void showProductDetailBottomSheet(
      BuildContext context, Product product,
      {ProductActionModalAction action: ProductActionModalAction.both}) {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      backgroundColor: Colors.white,
      builder: (BuildContext context) {
        return ProductActionModalBody(
          product,
          action: action,
        );
      },
    );
  }
}

class ProductActionModalBody extends StatelessWidget {
  final ProductActionModalAction action;
  final Product product;

  const ProductActionModalBody(
    this.product, {
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
            buildInfoAndPrice(context),
            SizedBox(height: 10),
            divider(),
            ConstrainedBox(
              constraints: BoxConstraints(maxHeight: 300),
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.all(AppTheme.paddingStandard),
                  child: Column(
                    children: <Widget>[
                      ProductVariant(product, enumVariantViewType.SELECTION),
                    ],
                  ),
                ),
              ),
            ),
            divider(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    FlutterI18n.translate(
                            context, "shopping.productDetail.quantity") +
                        " (${product.consumerPriceUom})",
                    style: TextStyle(fontWeight: FontWeight.w500),
                  ),
//                  TouchSpin(),
                  QuantityInput(),
                ],
              ),
            ),
            buildActionButtons(context)
          ],
        ),
      ),
    );
  }

  Widget buildInfoAndPrice(BuildContext context) {
    return Row(
//              mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,

      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(
            top: 20,
            left: 20,
          ),
          child: Image.network(
            ResourceUtil.fullPath(product.images[0].imageUrl),
            fit: BoxFit.cover,
            height: 90,
            width: 90,
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(
              left: 10.0,
              right: 10,
              top: 20,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(product.name + "fd fdsa fdas fds afdsafdsa"),
                SizedBox(
                  height: 10,
                ),
                product.consumerPrice > 0
                    ? Text(
                        "${product.consumerPriceCurrency} ${FormatUtil.formatPrice(product.consumerPrice)}",
                        style: TextStyle(
                            color: AppTheme.colorOrange,
                            fontSize: 19,
                            fontWeight: FontWeight.bold),
                      )
                    : SizedBox.shrink()
              ],
            ),
          ),
        ),
        GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTap: () => Navigator.pop(context),
          child: Padding(
            padding: EdgeInsets.only(top: 20.0, right: 20),
            child: FaIcon(FontAwesomeIcons.lightTimes),
          ),
        )
      ],
    );
  }

  Widget divider() => Divider(height: 1, thickness: 1);

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
  final Company sellerCompany;
  final CompanyProfile sellerCompanyProfile;

  ProductDetailBloc productDetailBloc;

  ProductDetailBody(
    this.product,
    this.sellerCompany,
    this.sellerCompanyProfile, {
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    productDetailBloc = BlocProvider.of<ProductDetailBloc>(context);

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
          (isNotBlank(product.keySellingPoint))
              ? AppListTitle.noTopPadding(FlutterI18n.translate(
                  context, "shopping.productDetail.keyProductAdvantage"))
              : SizedBox.shrink(),
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
    if (isBlank(sellerCompanyProfile.longIntroduction)) return null;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Text(
          FlutterI18n.translate(
              context, "shopping.productDetail.companyIntroduction"),
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 10),
        AppHtml(sellerCompanyProfile.longIntroduction),
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
              child: AppLabelValue(
                  FlutterI18n.translate(
                      context, "shopping.productDetail.company"),
                  sellerCompany.name),
            ),
            Expanded(
              child: AppLabelValue(
                FlutterI18n.translate(
                    context, "shopping.productDetail.businessType"),
                DataSourceHelper.getLabels(
                    values: sellerCompany.businessType,
                    lvs: productDetailBloc.businessTypeLvs),
              ),
            ),
          ],
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(
              child: AppLabelValue(
                FlutterI18n.translate(
                    context, "shopping.productDetail.location"),
                sellerCompany.countryName,
              ),
            ),
            Expanded(
              child: AppLabelValue(
                FlutterI18n.translate(
                    context, "shopping.productDetail.totalEmployees"),
                DataSourceHelper.getLabel(
                    value: sellerCompany.totalEmployees,
                    lvs: productDetailBloc.totalEmployeeLvs),
              ),
            ),
          ],
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(
              child: AppLabelValue(
                FlutterI18n.translate(
                    context, "shopping.productDetail.yearRegistered"),
                sellerCompany.yearRegistered,
              ),
            ),
            Expanded(
              child: AppLabelValue(
                FlutterI18n.translate(
                    context, "shopping.productDetail.totalAnnualRevenue"),
                DataSourceHelper.getLabel(
                    value: sellerCompanyProfile.totalAnnualRevenue),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget buildRatings(BuildContext context) {
    return ProductRating(product);
  }

  Widget buildReviews(BuildContext context) {
    return ProductReview(product);
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
            ProductVariant(product, enumVariantViewType.ALL),
            () => CheckSession.checkSession(
              context,
              () {
                ProductDetailScreen.showProductDetailBottomSheet(
                    context, product);
              },
            ),
          ),
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
    if (sellerCompany != null && sellerCompany.image != null) {
      return Padding(
        padding: EdgeInsets.only(right: 10),
        child: SizedBox(
          width: 30,
          child: Container(
            child: Image.network(
              ResourceUtil.fullPath(sellerCompany.image.imageUrl),
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

    if (sellerCompanyProfile != null &&
        sellerCompanyProfile.locations != null) {
      Location location = sellerCompanyProfile.locations
          .firstWhere((element) => element.supplyLocation);

      if (location != null) {
        if (isBlank(locationInfo))
          locationInfo = location.city +
              (isBlank(location.state) ? '' : ', ' + location.state);
        if (isBlank(locationInfo)) locationInfo = location.countryName;
      }
    }

    if (isBlank(locationInfo)) {
      if (sellerCompany != null) {
        if (isBlank(locationInfo)) locationInfo = sellerCompany.city;
        if (isBlank(locationInfo)) locationInfo = sellerCompany.countryName;
      }
    }

    return locationInfo;
  }
}

class ProductDetailScreenParams {
  final Product product;

  ProductDetailScreenParams({this.product});
}
