import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:storeFlutter/blocs/shopping/product-listing-bloc.dart';
import 'package:storeFlutter/components/app-button.dart';
import 'package:storeFlutter/components/app-general-error-info.dart';
import 'package:storeFlutter/components/shopping/product-listing-grid.dart';
import 'package:storeFlutter/components/shopping/shopping-cart-icon.dart';
import 'package:storeFlutter/components/shopping/static-search-bar.dart';
import 'package:storeFlutter/models/query-result.dart';
import 'package:storeFlutter/models/shopping/product.dart';
import 'package:storeFlutter/screens/shopping/search-general.dart';
import 'package:storeFlutter/services/product-service.dart';
import 'package:storeFlutter/util/app-theme.dart';

class ProductListingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final ProductListingScreenParams args =
        ModalRoute.of(context).settings.arguments;
    String query = args.query;

    return Scaffold(
      backgroundColor: AppTheme.colorBg2,
      appBar: AppBar(
        titleSpacing: 0,
        title: Row(
          children: <Widget>[
            Expanded(
              child: StaticSearchBar(query),
            ),
            SizedBox(width: 10),
            ShoppingCartIcon(),
            SizedBox(width: 10),
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
        ),
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: BlocProvider<ProductListingBloc>(
        create: (context) => ProductListingBloc()
          ..add(ProductListingSearch(ProductListingQueryFilter(query: query))),
        child: Builder(
          builder: (context) => ProductListingBody(),
        ),
      ),
    );
  }
}

class ProductListingBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductListingBloc, ProductListingState>(
      builder: (context, state) {
        if (state is ProductListingSearchInProgress) {
//          return Padding(
//            padding: EdgeInsets.only(top: 60),
//            child: AppLoading(),
//          );
          return ProductListingResult(state.result);
        } else if (state is ProductListingSearchComplete) {
          return ProductListingResult(state.result);
        } else if (state is ProductListingSearchError) {
          return AppGeneralErrorInfo(state.error);
        }
        return Container();
      },
    );
  }
}

class ProductListingResult extends StatelessWidget {
  final QueryResult<Product> result;

  ProductListingResult(this.result);

  @override
  Widget build(BuildContext context) {
    if (result.total == 0) {
      return ProductNotFound();
    } else {
      return SafeArea(
        child: Column(
          children: <Widget>[
            buildToolbar(context),
            Expanded(child: ProductListingGrid(result.items)),
          ],
        ),
      );
    }
  }

  Widget buildToolbar(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border(bottom: BorderSide(color: AppTheme.colorGray3))),
      child: Row(
        children: <Widget>[
          FlatButton(
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 10),
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            child: Text(
              FlutterI18n.translate(context, "shopping.sort.recommended"),
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.normal,
                color: AppTheme.colorOrange,
              ),
            ),
            onPressed: () {},
          ),
          FlatButton(
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 10),
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            child: Text(
              FlutterI18n.translate(context, "shopping.sort.popularity"),
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.normal,
                color: AppTheme.colorLink,
              ),
            ),
            onPressed: () {},
          ),
          Spacer(),
          FilterButton(),
          SizedBox(width: 10),
//          Text("123"),
//          Text("123"),
        ],
      ),
    );
  }
}

class FilterButton extends StatelessWidget {
  final double iconPaddingHeight = 5;
  const FilterButton({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () => _tap(context),
      child: Stack(
        children: <Widget>[
          Column(
            children: <Widget>[
              SizedBox(
                height: iconPaddingHeight,
              ),
              Padding(
                padding: EdgeInsets.only(right: 5),
                child: FaIcon(
                  FontAwesomeIcons.lightFilter,
//                  color: Colors.white,
                  size: 18,
                ),
              ),
              SizedBox(
                height: iconPaddingHeight,
              ),
            ],
          ),
          Positioned(
            right: 0,
            child: Container(
              decoration: BoxDecoration(
                color: AppTheme.colorOrange,
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
              child: Padding(
                padding: EdgeInsets.all(3),
                child: FaIcon(
                  FontAwesomeIcons.solidCheck,
                  size: 7,
                  color: Colors.white,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  void _tap(BuildContext context) {
    // TODO display filter
  }
}

class ProductNotFound extends StatelessWidget {
  const ProductNotFound({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(AppTheme.paddingStandard),
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: 50),
            FaDuotoneIcon(
              FontAwesomeIcons.duotoneFrown,
              secondaryColor: AppTheme.colorGray6,
              primaryColor: AppTheme.colorGray6.withOpacity(0.4),
              size: 40,
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              FlutterI18n.translate(context, "shopping.weAreSorry"),
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 18,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              FlutterI18n.translate(context, "shopping.cannotFindMatch"),
              style: TextStyle(color: AppTheme.colorGray6),
            ),
            SizedBox(
              height: 20,
            ),
            AppButton(
              FlutterI18n.translate(context, "shopping.tryDifferentKeywords"),
              () => _tap(context),
              size: AppButtonSize.small,
            ),
          ],
        ),
      ),
    );
  }

  void _tap(BuildContext context) {
    Navigator.of(context).push(PageRouteBuilder(
      fullscreenDialog: true,
      opaque: false,
      pageBuilder: (BuildContext context, _, __) => SearchGeneral(),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        var begin = Offset(0.0, 1.0);
        var end = Offset.zero;
        var curve = Curves.ease;

        var tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
    ));
  }
}

class ProductListingScreenParams {
  final String query;

  ProductListingScreenParams({this.query});
}
