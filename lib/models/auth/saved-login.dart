import 'package:json_annotation/json_annotation.dart';

part 'saved-login.g.dart';

@JsonSerializable()
class SavedLogin {
  String username;
  String password;

  SavedLogin(this.username, this.password);

  factory SavedLogin.fromJson(Map<String, dynamic> json) =>
      _$SavedLoginFromJson(json);

  Map<String, dynamic> toJson() => _$SavedLoginToJson(this);
}
