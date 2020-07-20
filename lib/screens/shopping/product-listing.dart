import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:storeFlutter/blocs/shopping/product-listing-bloc.dart';
import 'package:storeFlutter/components/shopping/shopping-cart-icon.dart';
import 'package:storeFlutter/components/shopping/static-search-bar.dart';
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
      body: SingleChildScrollView(
        child: BlocProvider<ProductListingBloc>(
          create: (context) =>
              ProductListingBloc()..add(ProductListingSearch(query)),
          child: Builder(
            builder: (context) => ProductListingBody(),
          ),
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
          return CircularProgressIndicator();
        } else if (state is ProductListingSearchComplete) {
          return Text("total result ${state.result.total}");
        } else if (state is ProductListingSearchError) {
          // TODO beautify the error for generic component
          return Text("Error retrieving : ${state.error}");
        }
        return Container();
      },
    );
  }
}

class ProductListingGrid extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class ProductListingGridItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class ProductListingScreenParams {
  final String query;

  ProductListingScreenParams({this.query});
}
