// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'lst-function.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LstFunction _$LstFunctionFromJson(Map<String, dynamic> json) {
  return LstFunction(
    json['functionID'] as int,
    json['microService'] as String,
    json['module'] as String,
    json['clientAccess'] as String,
    json['serverUrl'] as String,
    json['description'] as String,
    json['httpMethod'] as String,
  );
}

Map<String, dynamic> _$LstFunctionToJson(LstFunction instance) =>
    <String, dynamic>{
      'functionID': instance.functionID,
      'microService': instance.microService,
      'module': instance.module,
      'clientAccess': instance.clientAccess,
      'serverUrl': instance.serverUrl,
      'description': instance.description,
      'httpMethod': instance.httpMethod,
    };
