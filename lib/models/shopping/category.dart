import 'package:json_annotation/json_annotation.dart';
import 'package:storeFlutter/models/image.dart';
import 'package:storeFlutter/models/shopping/characteristic.dart';
import 'package:storeFlutter/models/shopping/property.dart';
import 'package:storeFlutter/models/shopping/variant-family.dart';

part 'category.g.dart';

@JsonSerializable()
class Category {
  int id;
  String code;
  String name;
  VariantFamily variantFamily;
  Category parentCategory;
  List<Property> properties;
  List<Characteristic> characteristics;
  Image image;

  Category(this.id, this.code, this.name, this.variantFamily,
      this.parentCategory, this.properties, this.characteristics, this.image);

  factory Category.fromJson(Map<String, dynamic> json) =>
      _$CategoryFromJson(json);

  Map<String, dynamic> toJson() => _$CategoryToJson(this);
}
