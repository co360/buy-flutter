import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:storeFlutter/blocs/shopping/product-detail-bloc.dart';
import 'package:storeFlutter/models/shopping/product.dart';
import 'package:storeFlutter/models/shopping/sku.dart';
import 'package:storeFlutter/models/shopping/variant-type-value.dart';
import 'package:storeFlutter/models/shopping/variant-type.dart';
import 'package:storeFlutter/services/variant-type-service.dart';
import 'package:storeFlutter/util/app-theme.dart';
import 'package:storeFlutter/util/enums-util.dart';

class ProductVariant extends StatelessWidget {
  final VariantTypeService _variantTypeService = GetIt.I<VariantTypeService>();

  final Product product;
  enumVariantViewType viewType;
  ProductDetailBloc productDetailBloc;

//  List<VariantOption> variantOptions = [];

  ProductVariant(this.product, this.viewType, this.productDetailBloc);

  @override
  Widget build(BuildContext context) {
    List<VariantOption> options;
    if (productDetailBloc == null) {
      return FutureBuilder<List<VariantOption>>(
        future: buildVariantOptions(),
        builder: (BuildContext context,
            AsyncSnapshot<List<VariantOption>> snapshot) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
//          children: snapshot.data.map((e) => VariantOptionWidget(e)).toList(),
            children: buildVariantOptionWidget(snapshot.data),
          );
        },
      );
    }
    return BlocBuilder<ProductDetailBloc, ProductDetailState>(
        bloc: productDetailBloc,
        builder: (context, state) {
          if (state is ProductDetailLoadComplete) {
            productDetailBloc.add(ProductDetailSkuLoad(buildVariantOptions));
          } else if (state is ProductDetailSkuInit) {
            this.viewType = enumVariantViewType.SELECTION;
            productDetailBloc.add(ProductDetailSkuLoad(buildVariantOptions));
          } else if (state is ProductDetailSelectVariant) {
            productDetailBloc.add(ProductDetailSkuCheck());
          } else if (state is ProductDetailSkuViewLoaded) {
            this.viewType = enumVariantViewType.ALL;
          }
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children:
                buildVariantOptionWidget(productDetailBloc.variantOptions),
          );
        });
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

  Future<List<VariantOption>> buildVariantOptionsMock() async {
    List<VariantOption> variantOptions = [];

    var option = VariantOption();
    VariantType type = VariantType(1, "Packging", "Packging", null, null);
    option.variantType = type;
    option.values.add("25 KG");
    option.values.add("50 KG");
    option.values.add("100 KG");
    option.values.add("200 KG");
    option.values.add("300 KG");
    option.values.add("1000 KG");

    variantOptions.add(option);

    option = VariantOption();
    type = VariantType(2, "Palletization", "Palletization", null, null);
    option.variantType = type;
    option.values.add("Non Palletize");
    option.values.add("Palletize");

    variantOptions.add(option);

    return variantOptions;
  }

  Future<List<VariantOption>> buildVariantOptions() async {
    // TODO copy from angular product-variant.component.ts?
//    int index = 0;

    List<VariantOption> variantOptions = [];
    List<Sku> variantSkus = product.variantSkus;
    for (var i = 0;
        i < product.category.variantFamily.variantTypes.length;
        i++) {
      VariantType type = product.category.variantFamily.variantTypes[i];

      var option = VariantOption();
      if (i > 0) {
        option.parentOption = variantOptions[i - 1];
      }

//      VariantType type = await _variantTypeService.get(temp.id);

      option.variantType = type;

      variantSkus.forEach((sku) {
        if (option.parentOption == null) {
          final variantValue = sku.variantValues[i];
          VariantTypeValue temp = variantValue.variantType.variantTypeValues
              .firstWhere((vv) => vv.id.toString() == variantValue.value,
                  orElse: () => null);
          if (temp == null && !(variantValue.value is int)) {
            temp =
                VariantTypeValue(0, variantValue.label, variantValue.value, 0);
          }
          if (temp != null && !option.values.contains(temp.value)) {
            option.values.add(temp.value);
            if (variantValue.label != null) {
              option.labels.add(variantValue.label);
            } else {
              if (variantValue.variantType != null &&
                  variantValue.variantType.variantTypeValues != null) {
                variantValue.variantType.variantTypeValues.forEach((v) {
                  if (variantValue.value == v.value.toString()) {
                    option.labels.add(v.name);
                  }
                });
              }
            }
          }
        } else {
          final parentValue = sku.variantValues[i - 1];
          final variantValue = sku.variantValues[i];

          VariantTypeValue tempParent;
          tempParent = parentValue.variantType.variantTypeValues.firstWhere(
              (finder) => finder.id.toString() == parentValue.value,
              orElse: () => null);
          if (tempParent == null && !(parentValue.value is int)) {
            tempParent =
                VariantTypeValue(0, parentValue.label, parentValue.value, 0);
          }
          VariantTypeValue temp;
          temp = variantValue.variantType.variantTypeValues.firstWhere(
              (finder) => finder.id.toString() == variantValue.value,
              orElse: () => null);
          if (temp == null && !(variantValue.value is int)) {
            temp =
                VariantTypeValue(0, variantValue.label, variantValue.value, 0);
          }

          //if parent selected
          if (option.parentOption.selectedValue != null) {
            if (tempParent.value == option.parentOption.selectedValue &&
                !option.values.contains(temp.value)) {
              option.values.add(temp.value);
              if (variantValue.label != null) {
                option.labels.add(variantValue.label);
              } else {
                if (variantValue.variantType != null &&
                    variantValue.variantType.variantTypeValues != null) {
                  variantValue.variantType.variantTypeValues.forEach((v) {
                    if (variantValue.value.toString() == v.value) {
                      option.labels.add(v.name);
                    }
                  });
                }
                // option.labels.push(variantValue.value);
              }
            }
          } else {
            if (!option.values.contains(temp.value)) {
              option.values.add(temp.value);
              if (variantValue.label != null) {
                option.labels.add(variantValue.label);
              } else {
                if (variantValue.variantType != null &&
                    variantValue.variantType.variantTypeValues != null) {
                  variantValue.variantType.variantTypeValues.forEach((v) {
                    if (variantValue.value.toString() == v.value) {
                      option.labels.add(v.name);
                    }
                  });
                }
                // option.labels.push(variantValue.value);
              }
            }
          }
        }
      });

//      type.variantTypeValues.forEach((vtv) {
//        print("variant type value $vtv");
//        option.labels.add(vtv.name);
//        option.values.add(vtv.value);
//      });
//      variantOptions.add(option);
      if (productDetailBloc.selectedSku != null) {
        VariantTypeValue temp;
        temp = productDetailBloc
            .selectedSku.variantValues[i].variantType.variantTypeValues
            .firstWhere((finder) =>
                finder.id.toString() ==
                productDetailBloc.selectedSku.variantValues[i].value);
        if (temp == null &&
            !(productDetailBloc.selectedSku.variantValues[i].value is int)) {
          temp = VariantTypeValue(
              0,
              productDetailBloc.selectedSku.variantValues[i].label,
              productDetailBloc.selectedSku.variantValues[i].value,
              0);
        }
        if (temp != null) {
          option.selectedValue = temp.value;
        }
      }
      if (option.selectedValue == null &&
          viewType == enumVariantViewType.SELECTION) {
        option.selectedValue = option.values != null ? option.values[0] : "";
      }
      variantOptions.add(option);
    }

    return variantOptions;
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
//        this.option.selectedValue = this.value;
//        if (this.viewType == enumVariantViewType.SELECTION)
              productDetailBloc
                  .add(ProductDetailVariantSelection(option, value));
            }
          : null,
      behavior: HitTestBehavior.translucent,
      child: Container(
        decoration: BoxDecoration(
          color: option.selectedValue == this.value
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
                color: option.selectedValue == this.value
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
