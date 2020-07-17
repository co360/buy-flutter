import 'package:json_annotation/json_annotation.dart';

part 'access-token.g.dart';

@JsonSerializable()
class AccessToken {
  @JsonKey(name: 'access_token')
  String accessToken;
  @JsonKey(name: 'token_type')
  String tokenType;
  @JsonKey(name: 'refresh_token')
  String refreshToken;
  @JsonKey(name: 'expires_in')
  int expiresIn;
  String scope;
  @JsonKey(ignore: true)
  String error;

  AccessToken(this.accessToken, this.tokenType, this.refreshToken,
      this.expiresIn, this.scope);

  factory AccessToken.fromJson(Map<String, dynamic> json) =>
      _$AccessTokenFromJson(json);

  AccessToken.withError(this.error);

  Map<String, dynamic> toJson() => _$AccessTokenToJson(this);

  @override
  String toString() {
    return 'AccessToken{accessToken: $accessToken, tokenType: $tokenType, refreshToken: $refreshToken, expiresIn: $expiresIn, scope: $scope}';
  }
}
