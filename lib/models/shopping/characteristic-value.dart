import 'package:json_annotation/json_annotation.dart';
import 'package:storeFlutter/models/shopping/characteristic.dart';

part 'characteristic-value.g.dart';

@JsonSerializable()
class CharacteristicValue {
  Characteristic characteristic;
  String value;

  CharacteristicValue({this.characteristic, this.value});

  factory CharacteristicValue.fromJson(Map<String, dynamic> json) =>
      _$CharacteristicValueFromJson(json);

  Map<String, dynamic> toJson() => _$CharacteristicValueToJson(this);
}
