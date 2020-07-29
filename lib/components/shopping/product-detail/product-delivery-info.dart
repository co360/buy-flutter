import 'package:flutter/material.dart';
import 'package:storeFlutter/models/shopping/product.dart';

class ProductDeliveryInfo extends StatelessWidget {
  final Product product;

  ProductDeliveryInfo(this.product);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text("delivery info widget"),
    );
  }
}
