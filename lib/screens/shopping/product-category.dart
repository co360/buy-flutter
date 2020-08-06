import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:storeFlutter/components/shopping/category-lists.dart';
import 'package:storeFlutter/components/button/grid-button-left.dart';
import 'package:storeFlutter/components/button/grid-button-top.dart';
import 'package:storeFlutter/blocs/shopping/product-category-bloc.dart';
import 'package:storeFlutter/models/query-result-category.dart';
import 'package:storeFlutter/screens/shopping/product-listing.dart';

class ProductCategoryScreen extends StatefulWidget {
  @override
  _ProductCategoryScreenState createState() => _ProductCategoryScreenState();
}

class _ProductCategoryScreenState extends State<ProductCategoryScreen> {
  @override
  void initState() {
    print("[ProductCategoryScreen] Initialize");
    // SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);
    GetIt.I<ProductCategoryBloc>().add(LoadProductCategoryEvent(0));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: I18nText("shopping.browse"),
        ),
        body: SafeArea(
          child: BlocBuilder<ProductCategoryBloc, ProductCategoryState>(
              bloc: GetIt.I<ProductCategoryBloc>(),
              builder: (context, state) {
                if (state is ProductCategoryLists) {
                  return GestureDetector(
                      onTap: () => {},
                      behavior: HitTestBehavior.translucent,
                      child: Row(children: <Widget>[
                        Container(
                          child: SizedBox(
                            width: MediaQuery.of(context).size.width * 0.30,
                            child: SingleChildScrollView(
                              child: Column(
                                  children:
                                      _generateDynamicList(state.categories)),
                            ),
                          ),
                        ),
                        Container(
                          color: Colors.white,
                          padding: const EdgeInsets.only(top: 20.0),
                          alignment: Alignment.topLeft,
                          child: SizedBox(
                            width: MediaQuery.of(context).size.width * 0.70,
                            child: SingleChildScrollView(
                              child: Column(
                                children: <Widget>[
                                  GridButtonTop(
                                      title: state == null
                                          ? ""
                                          : state
                                              .categories
                                              .layer1Category[
                                                  state.layerOneIndex >= 0
                                                      ? state.layerOneIndex
                                                      : 0]
                                              .name,
                                      cb: () {
                                        print("Select top button " +
                                            state.categories.layer1Category[0]
                                                .name);
                                        int index = state.layerOneIndex >= 0
                                            ? state.layerOneIndex
                                            : 0;
                                        Navigator.pushNamedAndRemoveUntil(
                                            context,
                                            '/product-listing',
                                            ModalRoute.withName('/'),
                                            arguments:
                                                ProductListingScreenParams(
                                                    category: state
                                                        .categories
                                                        .layer1Category[index]
                                                        .code));
                                      }),
                                  CategoryLists()
                                ],
                              ),
                            ),
                          ),
                        )
                      ]));
                } else {
                  return Container();
                }
              }),
        ));
  }

  List<Widget> _generateDynamicList(QueryResultCategory categories) {
    List<Widget> list = List();
    for (var _c in categories.layer1Category) {
      list.add(GridButtonLeft(
          title: _c.name,
          isActive: _c.isActive,
          cb: () {
            print("Select id ${_c.id}");
            GetIt.I<ProductCategoryBloc>()
                .add(SwitchProductCategoryEvent(_c.id));
          }));
    }
    return list;
  }
}
