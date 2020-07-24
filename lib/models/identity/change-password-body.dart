import 'package:json_annotation/json_annotation.dart';

part 'change-password-body.g.dart';

@JsonSerializable()
class ChangePasswordBody {
  String userId;
  String oldPassword;
  String newPassword;

  ChangePasswordBody(this.userId, this.oldPassword, this.newPassword);

  factory ChangePasswordBody.fromJson(Map<String, dynamic> json) =>
      _$ChangePasswordBodyFromJson(json);

  Map<String, dynamic> toJson() => _$ChangePasswordBodyToJson(this);

  @override
  String toString() {
    return 'ChangePasswordBody{userId: $userId, oldPassowrd: $oldPassword, newPassword: $newPassword}';
  }
}
