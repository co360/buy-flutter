import 'package:json_annotation/json_annotation.dart';
import 'package:storeFlutter/models/shopping/characteristic-item.dart';

part 'characteristic.g.dart';

@JsonSerializable()
class Characteristic {
  int characteristicID;
  String code;
  String name;
  String prefix;
  String postfix;
  int min;
  int max;
  String mandatory;
  List<CharacteristicItem> lstItem;

  CharType charType;

  Characteristic(
      this.characteristicID,
      this.code,
      this.name,
      this.prefix,
      this.postfix,
      this.min,
      this.max,
      this.mandatory,
      this.lstItem,
      this.charType);

  factory Characteristic.fromJson(Map<String, dynamic> json) =>
      _$CharacteristicFromJson(json);

  Map<String, dynamic> toJson() => _$CharacteristicToJson(this);
}

enum CharType { TEXT, DATASOURCE, NUMBER, GROUP }
