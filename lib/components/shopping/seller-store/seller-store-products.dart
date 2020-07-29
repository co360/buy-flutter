import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:storeFlutter/models/identity/company-profile.dart';
import 'package:storeFlutter/models/identity/company.dart';
import 'package:storeFlutter/models/shopping/product.dart';
import 'package:storeFlutter/models/filter-type.dart';
import 'package:storeFlutter/blocs/shopping/product-listing-bloc.dart';
import 'package:storeFlutter/components/shopping/product-listing/product-listing-grid.dart';
import 'package:storeFlutter/components/app-general-error-info.dart';
import 'package:storeFlutter/services/product-service.dart';

class SellerStoreProducts extends StatelessWidget {
  final Company sellerCompany;
  final CompanyProfile sellerCompanyProfile;

  const SellerStoreProducts(
    this.sellerCompany,
    this.sellerCompanyProfile, {
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Map<String, FilterValue> filter = {
      "companyId": FilterValue(
          sellerCompany.id.toString(), sellerCompany.id.toString(), 0)
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
    return BlocBuilder<ProductListingBloc, ProductListingState>(
      builder: (context, state) {
        if (state is ProductListingSearchInProgress) {
          return generateListing(context, state.result.items);
        } else if (state is ProductListingSearchComplete) {
          return generateListing(context, state.result.items);
        } else if (state is ProductListingSearchError) {
          return AppGeneralErrorInfo(state.error);
        }
        return Container();
      },
    );
  }

  Widget generateListing(BuildContext context, List<Product> products) {
    return Container(child: ProductListingGrid(products));
  }
}
