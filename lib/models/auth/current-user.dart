import 'package:json_annotation/json_annotation.dart';

part 'current-user.g.dart';

@JsonSerializable()
class CurrentUser {
  String username;
  List<dynamic> authorities;
  String firstName;
  String lastName;
  String email;
  int companyId;
  String companyCode;

  CurrentUser(this.username, this.authorities, this.firstName, this.lastName,
      this.email, this.companyId, this.companyCode);

  factory CurrentUser.fromJson(Map<String, dynamic> json) =>
      _$CurrentUserFromJson(json);

  Map<String, dynamic> toJson() => _$CurrentUserToJson(this);
}
