// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'characteristic-item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CharacteristicItem _$CharacteristicItemFromJson(Map<String, dynamic> json) {
  return CharacteristicItem(
    json['characteristicItemId'] as int,
    json['inputValue'] as String,
  );
}

Map<String, dynamic> _$CharacteristicItemToJson(CharacteristicItem instance) =>
    <String, dynamic>{
      'characteristicItemId': instance.characteristicItemId,
      'inputValue': instance.inputValue,
    };
