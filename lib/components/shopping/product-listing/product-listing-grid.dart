import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:storeFlutter/blocs/shopping/product-listing-bloc.dart';
import 'package:storeFlutter/components/app-loading.dart';
import 'package:storeFlutter/components/shopping/product-listing/product-listing-grid-item.dart';
import 'package:storeFlutter/models/query-result.dart';
import 'package:storeFlutter/models/shopping/product.dart';
import 'package:storeFlutter/util/app-theme.dart';

class ProductListingGrid extends StatefulWidget {
  final List<Product> products;

  ProductListingGrid(this.products);

  @override
  _ProductListingGridState createState() => _ProductListingGridState();
}

class _ProductListingGridState extends State<ProductListingGrid> {
  ScrollController _scrollController;
  ProductListingSearchComplete completeState;
  bool loadingMore = false;

  @override
  void initState() {
    _scrollController = new ScrollController();
    _scrollController.addListener(() => _scrollListener());
    super.initState();
  }

  _scrollListener() {
    if (completeState == null) return;

    if (completeState.result.hasMorePage()) {
      double maxScroll = _scrollController.position.maxScrollExtent;
      double currentScroll = _scrollController.position.pixels;
      double delta = 200.0;
      if (!loadingMore &&
          _scrollController.position.userScrollDirection ==
              ScrollDirection.reverse &&
          (maxScroll - currentScroll <= delta)) {
        loadingMore = true;

        BlocProvider.of<ProductListingBloc>(context).add(ProductListingNextPage(
            context, completeState.queryFilter, completeState.result));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    int total = 0;

    if (widget.products != null) total = widget.products.length;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 4.0),
      child: StaggeredGridView.countBuilder(
        controller: _scrollController,
        crossAxisCount: 2,
        itemCount: total + 1,
        itemBuilder: (BuildContext context, int index) {
          if (index == total) {
            return buildLoadingTile();
          } else {
            return ProductListingGridItem(widget.products[index]);
          }
        },
        staggeredTileBuilder: (int index) {
          if (index == total) {
            return StaggeredTile.fit(2);
          } else {
            return StaggeredTile.fit(1);
          }
        },
        crossAxisSpacing: 4.0,
      ),
    );
  }

  Widget buildLoadingTile() {
    return BlocBuilder<ProductListingBloc, ProductListingState>(
      builder: (context, state) {
        if (state is ProductListingSearchInProgress) {
          return AppLoading();
        } else if (state is ProductListingSearchComplete) {
          QueryResult result = state.result;
          this.completeState = state;
          this.loadingMore = false;

          if (!result.hasMorePage()) {
            // reach end of page
            return Center(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 20.0),
                child: Text(
                  FlutterI18n.translate(context, "general.noMoreResults"),
                  style: TextStyle(
                    color: AppTheme.colorGray5,
                  ),
                ),
              ),
            );
          }
        }

        return Container();
      },
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}
