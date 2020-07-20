import 'package:json_annotation/json_annotation.dart';

part 'characteristic-item.g.dart';

@JsonSerializable()
class CharacteristicItem {
  int characteristicItemId;
  String inputValue;

  CharacteristicItem(this.characteristicItemId, this.inputValue);

  factory CharacteristicItem.fromJson(Map<String, dynamic> json) =>
      _$CharacteristicItemFromJson(json);

  Map<String, dynamic> toJson() => _$CharacteristicItemToJson(this);
}
