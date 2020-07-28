import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:storeFlutter/models/shopping/product.dart';
import 'package:storeFlutter/models/shopping/variant-type.dart';
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
      future: buildVariantOptionsMock(),
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
    print("buildvariantoptions ${product.category.variantFamily.variantTypes}");
//    int index = 0;

    List<VariantOption> variantOptions = [];
    for (var i = 0;
        i < product.category.variantFamily.variantTypes.length;
        i++) {
      VariantType temp = product.category.variantFamily.variantTypes[i];

      VariantType type = await _variantTypeService.get(temp.id);
      print(
          "return from service ${type.name}, ${type.code}, ${type.variantTypeValues}");

      var option = VariantOption();
      option.variantType = type;

      type.variantTypeValues.forEach((vtv) {
        print("variant type value $vtv");
        option.labels.add(vtv.name);
        option.values.add(vtv.value);
      });
      variantOptions.add(option);
      print("print labels ${option.labels}");
    }

    print("before return ${variantOptions}");
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
          children: option.values.map((e) {
            return VariantOptionValueWidget(e);
          }).toList(),
        ),
      ],
    );
  }
}

class VariantOptionValueWidget extends StatelessWidget {
  final String value;

  VariantOptionValueWidget(this.value);

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
