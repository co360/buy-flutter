import 'package:json_annotation/json_annotation.dart';

part 'refresh-token.g.dart';

@JsonSerializable()
class RefreshToken {
  @JsonKey(name: 'grant_type')
  String grantType;
  @JsonKey(name: 'refresh_token')
  String refreshToken;

  RefreshToken(this.grantType, this.refreshToken);

  factory RefreshToken.fromJson(Map<String, dynamic> json) =>
      _$RefreshTokenFromJson(json);

  Map<String, dynamic> toJson() => _$RefreshTokenToJson(this);

  @override
  String toString() {
    return 'RefreshToken{grantType: $grantType, refreshToken: $refreshToken}';
  }
}
