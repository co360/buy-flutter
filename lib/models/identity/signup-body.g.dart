// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'signup-body.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SignUpBody _$SignUpBodyFromJson(Map<String, dynamic> json) {
  return SignUpBody(
    json['account'] == null
        ? null
        : RegisterAccount.fromJson(json['account'] as Map<String, dynamic>),
    json['company'] == null
        ? null
        : RegisterCompany.fromJson(json['company'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$SignUpBodyToJson(SignUpBody instance) =>
    <String, dynamic>{
      'account': instance.account,
      'company': instance.company,
    };

RegisterAccount _$RegisterAccountFromJson(Map<String, dynamic> json) {
  return RegisterAccount(
    json['email'] as String,
    json['name'] as String,
    json['password'] as String,
    json['contact'] as String,
    json['accountType'] as String,
  );
}

Map<String, dynamic> _$RegisterAccountToJson(RegisterAccount instance) =>
    <String, dynamic>{
      'email': instance.email,
      'name': instance.name,
      'password': instance.password,
      'contact': instance.contact,
      'accountType': instance.accountType,
    };

RegisterCompany _$RegisterCompanyFromJson(Map<String, dynamic> json) {
  return RegisterCompany(
    json['name'] as String,
  );
}

Map<String, dynamic> _$RegisterCompanyToJson(RegisterCompany instance) =>
    <String, dynamic>{
      'name': instance.name,
    };
