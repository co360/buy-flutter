// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'refresh-token.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RefreshToken _$RefreshTokenFromJson(Map<String, dynamic> json) {
  return RefreshToken(
    json['grant_type'] as String,
    json['refresh_token'] as String,
  );
}

Map<String, dynamic> _$RefreshTokenToJson(RefreshToken instance) =>
    <String, dynamic>{
      'grant_type': instance.grantType,
      'refresh_token': instance.refreshToken,
    };
