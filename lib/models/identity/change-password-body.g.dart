// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'change-password-body.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ChangePasswordBody _$ChangePasswordBodyFromJson(Map<String, dynamic> json) {
  return ChangePasswordBody(
    json['userId'] as String,
    json['oldPassword'] as String,
    json['newPassword'] as String,
  );
}

Map<String, dynamic> _$ChangePasswordBodyToJson(ChangePasswordBody instance) =>
    <String, dynamic>{
      'userId': instance.userId,
      'oldPassword': instance.oldPassword,
      'newPassword': instance.newPassword,
    };
