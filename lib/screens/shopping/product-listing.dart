import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:storeFlutter/blocs/shopping/product-listing-bloc.dart';
import 'package:storeFlutter/components/app-button.dart';
import 'package:storeFlutter/components/app-general-error-info.dart';
import 'package:storeFlutter/components/app-loading.dart';
import 'package:storeFlutter/components/shopping/product-listing-grid.dart';
import 'package:storeFlutter/components/shopping/shopping-cart-icon.dart';
import 'package:storeFlutter/components/shopping/static-search-bar.dart';
import 'package:storeFlutter/models/filter-type.dart';
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
    Map<String, FilterValue> filter = args.filter;
    cacheMinPrice = null;
    cacheMaxPrice = null;

    return BlocProvider<ProductListingBloc>(
      create: (context) => ProductListingBloc()
        ..add(ProductListingSearch(ProductListingQueryFilter(query: query, filters: filter != null ? filter : {}))),
      child: Builder(
        builder: (context) {
          return Scaffold(
              backgroundColor: AppTheme.colorBg2,
              appBar: AppBar(
                titleSpacing: 0,
                title: Row(
                  children: <Widget>[
                    Expanded(
                      child: StaticSearchBar(
                          placeholder: FlutterI18n.translate(
                              context, "shopping.searchProductSeller"),
                          query: query),
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
                      colors: <Color>[
                        AppTheme.colorPrimary,
                        AppTheme.colorSuccess
                      ],
                    ),
                  ),
                ),
                iconTheme: IconThemeData(color: Colors.white),
                actions: <Widget>[SizedBox.shrink()],
              ),
              endDrawer: FilterDrawer(),
              body: ProductListingBody());
        },
      ),
    );
  }
}

final GlobalKey<FormBuilderState> _fbKey = GlobalKey<FormBuilderState>();
ProductListingSearchComplete cacheState;
String cacheMinPrice;
String cacheMaxPrice;

class FilterDrawer extends StatelessWidget {
//  const FilterDrawer({
//    Key key,
//  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
        canvasColor: Colors.white,
      ),
      child: Drawer(
          child: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(left: 20, right: 20, top: 20),
                child: buildFilterInput(),
              ),
            ),
            Container(child: buildActionButton(context)),
          ],
        ),
      )),
    );
  }

  Widget buildFilterInput() {
    return BlocBuilder<ProductListingBloc, ProductListingState>(
      builder: (context, state) {
        ProductListingBloc bloc = BlocProvider.of<ProductListingBloc>(context);
        if (state is ProductListingSearchInProgress) {
          // TODO should display the loading on top of the filter button like lazada etc
          cacheState = null;
          return Column(
            children: <Widget>[
              AppLoading(),
              Text(
                  "loading... should display the loading on top of the filter button like lazada etc"),
            ],
          );
        } else if (state is ProductListingSearchComplete) {
          List<FilterMeta> metas = state.result.filterMetas;
          return ListView(children: <Widget>[
            Container(
              child: ListView.builder(
                physics: ScrollPhysics(),
                shrinkWrap: true,
                itemCount: metas.length,
                itemBuilder: (BuildContext buildContext, int index) {
                  FilterMeta meta = metas[index];

                  if (meta.filterValues == null ||
                      meta.filterValues.length == 0) {
                    // skip if no filter values...
                    // TODO also might skip if the values is only one value.. cause pointless to filter anyway
                    return SizedBox.shrink();
                  }
                  cacheState = state;
                  // TODO do the "View More" if filter option more than 5
                  return buildFilterMeta(
                      meta, bloc, state.queryFilter, state.result);
                },
              ),
            ),
            buildPriceRangeInput(context)
          ]);
        } else if (state is ProductListingCategoryResetState) {
          bloc.add(ProductListingSearch(ProductListingQueryFilter(query: "", filters: {})));
          cacheMaxPrice = null;
          cacheMinPrice = null;
        } else if (state is ProductListingSearchError) {}
        return Text("nothing here");
      },
    );
  }

  Column buildFilterMeta(FilterMeta meta, ProductListingBloc bloc,
      ProductListingQueryFilter queryFilter, QueryResult<Product> result) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Text(
          meta.name,
          style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600),
        ),
        SizedBox(
          height: 10,
        ),
        Wrap(
          spacing: 10,
          children: meta.filterValues
              .map((e) => RaisedButton(
                    onPressed: () {
                      ProductListingQueryFilter newFilter =
                          ProductListingQueryFilter.copy(queryFilter);
                      newFilter.toggleFilter(meta.code, e);
                      bloc.add(ProductListingSearch(newFilter, result: result));
                    },
                    color: queryFilter.hasFilter(meta.code, e)
                        ? AppTheme.colorOrange
                        : AppTheme.colorGray2,
//            visualDensity: VisualDensity.compact,
                    padding: EdgeInsets.all(10),
                    child: Text(
                      e.name != null ? e.name : e.value,
                      style: TextStyle(
                          color: queryFilter.hasFilter(meta.code, e)
                              ? Colors.white
                              : Colors.black,
                          fontSize: 14,
                          fontWeight: FontWeight.w400),
                    ),
                  ))
              .toList(),
        ),
        SizedBox(
          height: 30,
        ),
      ],
    );
  }

  Widget buildActionButton(BuildContext context) {
    return Column(
      children: <Widget>[
        Divider(
          height: 1,
        ),
        SizedBox(height: 5),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Row(
            children: <Widget>[
              Expanded(
                child: AppButton(
                  FlutterI18n.translate(context, "general.reset"),
                  () {
                    BlocProvider.of<ProductListingBloc>(context)
                        .add(ProductListingSearchReset());
                  },
//                  noPadding: true,
                  bottomPadding: 5,
                  type: AppButtonType.white,
                  size: AppButtonSize.small,
                ),
              ),
              SizedBox(width: 10),
              Expanded(
                child: AppButton(
                  FlutterI18n.translate(context, "general.done"),
                  () {
                    //TODO refactor price range filter
                    if(cacheState != null) {
                      if (_fbKey.currentState.saveAndValidate()) {
                        cacheMaxPrice = _fbKey.currentState.value['maxPrice'];
                        cacheMinPrice = _fbKey.currentState.value['minPrice'];
                        if(cacheMinPrice != null || cacheMaxPrice != null) {
                          ProductListingQueryFilter newFilter =
                          ProductListingQueryFilter.copy(cacheState.queryFilter);
                          newFilter.toggleFilter(
                              "MIN_PRICE", FilterValue("MIN_PRICE",_fbKey.currentState.value['minPrice'],1));
                          newFilter.toggleFilter(
                              "MAX_PRICE",  FilterValue("MAX_PRICE",_fbKey.currentState.value['maxPrice'],1));
                          BlocProvider.of<ProductListingBloc>(context).add(
                              ProductListingSearch(
                                  newFilter, result: cacheState.result));
                        }
                      }
                    }
                    Navigator.of(context).pop();
                  },
//                  noPadding: true,
                  bottomPadding: 5,
                  size: AppButtonSize.small,
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}

Widget buildPriceRangeInput(BuildContext context) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: <Widget>[
      Text(
        FlutterI18n.translate(context, "shopping.filter.priceRange"),
        style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600),
      ),
      SizedBox(
        height: 10,
      ),
      FormBuilder(
        key: _fbKey,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Expanded(flex: 4, child: DecoratedPriceField("Min", "minPrice")),
            Expanded(
              flex: 1,
              child: Text(
                "-",
                style: TextStyle(fontSize: 14),
                textAlign: TextAlign.center,
              ),
            ),
            Expanded(flex: 4, child: DecoratedPriceField("Max", "maxPrice")),
          ],
        ),
      ),
      SizedBox(
        height: 30,
      ),
    ],
  );
}

class DecoratedPriceField extends StatelessWidget {
  final String hint;
  final String attribute;

  DecoratedPriceField(this.hint, this.attribute);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      child: FormBuilderTextField(
          attribute: attribute,
//          initialValue: attribute == "minPrice" ?
//                  cacheMinPrice > 0? cacheMinPrice.toString() : "" :
//                  cacheMaxPrice > 0? cacheMaxPrice.toString() : "",
          initialValue: _defaultValue(),
          textAlign: TextAlign.center,
          keyboardType: TextInputType.number,
          decoration: new InputDecoration(
            contentPadding: EdgeInsets.all(10.0),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey, width: 0.5),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.blue, width: 1),
            ),
            hintText: hint,
          )),
    );
  }

  String _defaultValue(){
    String defValue = "";
    if(attribute == "minPrice") {
      defValue = cacheMinPrice != null? cacheMinPrice : "";
    } else {
      defValue = cacheMaxPrice != null? cacheMaxPrice : "";
    }
    return defValue;
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
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            child: Text(
              FlutterI18n.translate(context, "shopping.sort.recommended"),
              style: TextStyle(
//                fontSize: 12,
                fontWeight: FontWeight.normal,
                color: AppTheme.colorOrange,
              ),
            ),
            onPressed: () {},
          ),
          FlatButton(
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            child: Text(
              FlutterI18n.translate(context, "shopping.sort.popularity"),
              style: TextStyle(
//                fontSize: 12,
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
    return BlocBuilder<ProductListingBloc, ProductListingState>(
        builder: (context, state) {
      Widget layer = Container();

      if (state is ProductListingSearchComplete) {
        if (state.queryFilter.hasAnyFilter()) {
          layer = Positioned(
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
          );
        }
      }

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
            layer
          ],
        ),
      );
    });
  }

  void _tap(BuildContext context) {
    Scaffold.of(context).openEndDrawer();
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
  final Map<String, FilterValue> filter;

  ProductListingScreenParams({this.query, this.filter});
}
