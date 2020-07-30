import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:storeFlutter/models/shopping/product.dart';
import 'package:storeFlutter/models/shopping/sku.dart';
import 'package:storeFlutter/models/shopping/variant-type-value.dart';
import 'package:storeFlutter/models/shopping/variant-type.dart';
import 'package:storeFlutter/models/shopping/variant-value.dart';
import 'package:storeFlutter/services/variant-type-service.dart';
import 'package:storeFlutter/util/app-theme.dart';

class ProductVariant extends StatelessWidget {
  final VariantTypeService _variantTypeService = GetIt.I<VariantTypeService>();

  final Product product;

//  List<VariantOption> variantOptions = [];

  ProductVariant(this.product);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<VariantOption>>(
      future: buildVariantOptions(),
      builder:
          (BuildContext context, AsyncSnapshot<List<VariantOption>> snapshot) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
//          children: snapshot.data.map((e) => VariantOptionWidget(e)).toList(),
          children: buildVariantOptionWidget(snapshot.data),
        );
      },
    );
  }

  List<Widget> buildVariantOptionWidget(List<VariantOption> options) {
    List<Widget> items = [];

    if (options != null) {
      items = options.map((e) => VariantOptionWidget(e)).toList();

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
              .firstWhere((vv) => vv.id.toString() == variantValue.value);
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
              (finder) => finder.id.toString() == parentValue.value);
          if (tempParent == null && !(parentValue.value is int)) {
            tempParent =
                VariantTypeValue(0, parentValue.label, parentValue.value, 0);
          }
          VariantTypeValue temp;
          temp = variantValue.variantType.variantTypeValues.firstWhere(
              (finder) => finder.id.toString() == variantValue.value);
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
      variantOptions.add(option);
    }

    return variantOptions;
  }
}

class VariantOptionWidget extends StatelessWidget {
  final VariantOption option;

  VariantOptionWidget(this.option);

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
            return VariantOptionValueWidget(e, option);
          }).toList(),
        ),
      ],
    );
  }
}

class VariantOptionValueWidget extends StatelessWidget {
  final String value;
  final VariantOption option;

  VariantOptionValueWidget(this.value, this.option);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppTheme.colorGray2,
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
          value,
          style: TextStyle(color: AppTheme.colorGray6),
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
