// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'saved-login.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SavedLogin _$SavedLoginFromJson(Map<String, dynamic> json) {
  return SavedLogin(
    json['username'] as String,
    json['password'] as String,
  );
}

Map<String, dynamic> _$SavedLoginToJson(SavedLogin instance) =>
    <String, dynamic>{
      'username': instance.username,
      'password': instance.password,
    };
