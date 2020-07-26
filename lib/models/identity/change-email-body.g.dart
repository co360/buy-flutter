// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'change-email-body.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ChangeEmailBody _$ChangeEmailBodyFromJson(Map<String, dynamic> json) {
  return ChangeEmailBody(
    json['email'] as String,
    json['newEmail'] as String,
    json['verificationCode'] as String,
  );
}

Map<String, dynamic> _$ChangeEmailBodyToJson(ChangeEmailBody instance) =>
    <String, dynamic>{
      'email': instance.email,
      'newEmail': instance.newEmail,
      'verificationCode': instance.verificationCode,
    };
