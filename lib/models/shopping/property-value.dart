import 'package:json_annotation/json_annotation.dart';
import 'package:storeFlutter/models/shopping/property.dart';

part 'property-value.g.dart';

@JsonSerializable()
class PropertyValue {
  Property property;
  String value;

  PropertyValue(this.property, this.value);

  factory PropertyValue.fromJson(Map<String, dynamic> json) =>
      _$PropertyValueFromJson(json);

  Map<String, dynamic> toJson() => _$PropertyValueToJson(this);
}
