import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:storeFlutter/components/shopping/product-listing-grid-item.dart';
import 'package:storeFlutter/models/shopping/product.dart';

class ProductListingGrid extends StatelessWidget {
  final List<Product> products;

  ScrollController _scrollController = new ScrollController();
  ProductListingGrid(this.products);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 4.0),
      child: StaggeredGridView.countBuilder(
        controller: _scrollController,
        crossAxisCount: 2,
        itemCount: products.length,
        itemBuilder: (BuildContext context, int index) =>
            ProductListingGridItem(products[index]),
//        staggeredTileBuilder: (int index) => new StaggeredTile.count(1, 1.7),
        staggeredTileBuilder: (int index) => new StaggeredTile.fit(1),
        crossAxisSpacing: 4.0,
      ),
    );
  }
}
