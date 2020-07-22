import 'package:json_annotation/json_annotation.dart';

part 'forget-password-body.g.dart';

@JsonSerializable()
class ForgetPasswordBody {
  String email;
  ForgetPasswordBody(this.email);

  factory ForgetPasswordBody.fromJson(Map<String, dynamic> json) =>
      _$ForgetPasswordBodyFromJson(json);

  Map<String, dynamic> toJson() => _$ForgetPasswordBodyToJson(this);

  @override
  String toString() {
    return 'ForgetPasswordBody{email: $email}';
  }
}
