import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:storeFlutter/blocs/shopping/product-listing-bloc.dart';
import 'package:storeFlutter/components/shopping/static-search-bar.dart';
import 'package:storeFlutter/models/shopping/product.dart';

class SellerStoreSearch extends StatelessWidget {
  const SellerStoreSearch({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductListingBloc, ProductListingState>(
      builder: (context, state) {
        if (state is ProductListingSearchComplete) {
          return buildChild(context, state.result.items);
        }
        return buildChild(context, []);
      },
    );
  }

  Widget buildChild(BuildContext context, List<Product> products) {
    return Expanded(
      child: StaticSearchBar(
        placeholder: FlutterI18n.translate(
            context, "shopping.sellerStorePage.searchProductSeller"),
        filterProduct: products,
      ),
    );
  }
}
