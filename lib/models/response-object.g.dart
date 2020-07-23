// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'response-object.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ResponseMessage _$ResponseMessageFromJson(Map<String, dynamic> json) {
  return ResponseMessage(
    json['type'] as String,
    json['message'] as String,
  );
}

Map<String, dynamic> _$ResponseMessageToJson(ResponseMessage instance) =>
    <String, dynamic>{
      'type': instance.type,
      'message': instance.message,
    };
