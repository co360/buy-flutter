import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:storeFlutter/blocs/shopping/product-detail-bloc.dart';
import 'package:storeFlutter/models/shopping/product.dart';
import 'package:storeFlutter/models/shopping/variant-type.dart';
import 'package:storeFlutter/util/app-theme.dart';
import 'package:storeFlutter/util/enums-util.dart';

class ProductVariant extends StatelessWidget {
  final Product product;
  enumVariantViewType viewType;
  ProductDetailBloc productDetailBloc;

  ProductVariant(this.product, this.viewType, this.productDetailBloc);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductDetailBloc, ProductDetailState>(
      bloc: productDetailBloc,
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: buildVariantOptionWidget(productDetailBloc.variantOptions),
        );
      },
    );
  }

  List<Widget> buildVariantOptionWidget(List<VariantOption> options) {
    List<Widget> items = [];

    if (options != null) {
      items = options
          .map((e) =>
              VariantOptionWidget(e, this.viewType, this.productDetailBloc))
          .toList();

      items = items
          .expand((e) => [
                e,
                SizedBox(
                  height: 20,
                )
              ])
          .toList();

      items.removeLast();
    }

    return items;
  }
}

class VariantOptionWidget extends StatelessWidget {
  final VariantOption option;
  final enumVariantViewType viewType;
  ProductDetailBloc productDetailBloc;

  VariantOptionWidget(this.option, this.viewType, this.productDetailBloc);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Text(option.variantType.name,
            style: TextStyle(fontWeight: FontWeight.bold)),
        SizedBox(
          height: 10,
        ),
        Wrap(
          spacing: 10,
          runSpacing: 10,
          children: option.labels.map((e) {
            int index = option.labels.indexOf(e);
            return VariantOptionValueWidget(
                index, option, viewType, productDetailBloc);
          }).toList(),
        ),
      ],
    );
  }
}

class VariantOptionValueWidget extends StatelessWidget {
  final int index;
  final VariantOption option;
  final enumVariantViewType viewType;
  String label;
  String value;
  ProductDetailBloc productDetailBloc;

  VariantOptionValueWidget(
      this.index, this.option, this.viewType, this.productDetailBloc) {
    this.value = this.option.values[this.index];
    this.label = this.option.labels[this.index];
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (this.viewType == enumVariantViewType.SELECTION)
          ? () {
              productDetailBloc.add(ProductDetailVariantSelection(
                  variantOption: option, value: value));
            }
          : null,
      behavior: HitTestBehavior.translucent,
      child: Container(
        decoration: BoxDecoration(
          color: option.selectedValue == this.value &&
                  this.viewType == enumVariantViewType.SELECTION
              ? AppTheme.colorGray8
              : AppTheme.colorGray2,
          borderRadius: BorderRadius.all(
            Radius.circular(5),
          ),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(
            vertical: 8.0,
            horizontal: 10,
          ),
          child: Text(
            this.label,
            style: TextStyle(
                color: option.selectedValue == this.value &&
                        this.viewType == enumVariantViewType.SELECTION
                    ? Colors.white
                    : AppTheme.colorGray6),
          ),
        ),
      ),
    );
  }
}

class VariantOption {
  VariantType variantType;
  List<String> values = [];
  List<String> labels = [];
  String selectedValue;
  VariantOption parentOption;
}
