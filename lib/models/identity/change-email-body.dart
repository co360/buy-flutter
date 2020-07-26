import 'package:json_annotation/json_annotation.dart';

part 'change-email-body.g.dart';

@JsonSerializable()
class ChangeEmailBody {
  String email;
  String newEmail;
  String verificationCode;

  ChangeEmailBody(this.email, this.newEmail, this.verificationCode);

  factory ChangeEmailBody.fromJson(Map<String, dynamic> json) =>
      _$ChangeEmailBodyFromJson(json);

  Map<String, dynamic> toJson() => _$ChangeEmailBodyToJson(this);

  @override
  String toString() {
    return 'ChangeEmailBody{email: $email, newEmail: $newEmail, verificationCode: $verificationCode}';
  }
}
