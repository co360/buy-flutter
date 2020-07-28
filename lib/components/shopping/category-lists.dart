import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:storeFlutter/components/shopping/category-grid-list.dart';
import 'package:storeFlutter/components/button/grid-button.dart';
import 'package:storeFlutter/components/button/grid-button-disable.dart';
import 'package:storeFlutter/blocs/shopping/product-category-bloc.dart';
import 'package:storeFlutter/models/filter-type.dart';
import 'package:storeFlutter/models/query-result-category.dart';
import 'package:storeFlutter/screens/shopping/product-listing.dart';

class CategoryLists extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductCategoryBloc, ProductCategoryState>(
      bloc: GetIt.I<ProductCategoryBloc>(),
      builder: (context, state) {
        if (state is ProductCategoryLists) {
          return Container(
            margin: const EdgeInsets.only(top: 20.0),
            child: Column(
              children: _generateDynamicList(state.categories, context),
            ),
          );
        } else if (state is ProductCategoryError) {
          return Text("Error retrieving : ${state.error}");
        }
        return Container();
      },
    );
  }

  List<Widget> _generateDynamicList(
      QueryResultCategory categories, BuildContext context) {
    List<Widget> list = List();

    // 2nd layer
    for (int i = 0; i < categories.layer2Category.length; i += 2) {
      list.add(
          Container(
          margin: const EdgeInsets.all(5.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              categories.layer2Category.length > i
                  ? GridButton(
                      title: categories.layer2Category[i].name,
                      cb: () {
                        print("Select ${categories.layer2Category[i].id}");
                        Navigator.pushNamedAndRemoveUntil(
                            context, '/product-listing', ModalRoute.withName('/'),
                            arguments: ProductListingScreenParams(filter: {"CATEGORY":FilterValue(categories.layer2Category[i].name,categories.layer2Category[i].code,0)}));
                      })
                  : GridButtonDisable(),
              categories.layer2Category.length > i + 1
                  ? GridButton(
                      title: categories.layer2Category[i + 1].name,
                      cb: () {
                        print("Select ${categories.layer2Category[i + 1].id}");
                        Navigator.pushNamedAndRemoveUntil(
                            context, '/product-listing', ModalRoute.withName('/'),
                            arguments: ProductListingScreenParams(filter: {"CATEGORY":FilterValue(categories.layer2Category[i+1].name,categories.layer2Category[i+1].code,0)}));
                      })
                  : GridButtonDisable(),
              // categories.layer2Category.length > i + 2
              //     ? GridButton(
              //         title: categories.layer2Category[i + 2].name,
              //         cb: () {
              //           print("Select ${categories.layer2Category[i + 2].id}");
              //         })
              //     : GridButtonDisable(),
            ],
          )));
    }

    // 3rd layer
    for (var _c in categories.layer2Category) {
      if (_c.layer3Category.length > 1) {
        list.add(CategoryGridList(_c));
      }
    }
    return list;
  }
}
