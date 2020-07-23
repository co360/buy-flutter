import 'package:json_annotation/json_annotation.dart';

part 'signup-body.g.dart';

@JsonSerializable()
class SignUpBody {
  RegisterAccount account;
  RegisterCompany company;
  SignUpBody(this.account, this.company);

  factory SignUpBody.fromJson(Map<String, dynamic> json) =>
      _$SignUpBodyFromJson(json);

  Map<String, dynamic> toJson() => _$SignUpBodyToJson(this);

  @override
  String toString() {
    return 'SignUpBody{account: $account, company: $company}';
  }

  static fromJsonFunc(Map<String, dynamic> json) {
    if(json != null){
      return _$SignUpBodyFromJson(json);
    }
    return null;
  }




}

@JsonSerializable()
class RegisterAccount {
  String email;
  String name;
  String password;
  String contact;
  String accountType;
  RegisterAccount(this.email, this.name, this.password, this.contact, this.accountType);

  factory RegisterAccount.fromJson(Map<String, dynamic> json) =>
      _$RegisterAccountFromJson(json);

  Map<String, dynamic> toJson() => _$RegisterAccountToJson(this);

  @override
  String toString() {
    return 'RegisterAccount{email: $email, name: $name, password: $password, contact: $contact, accountType: $accountType}';
  }
}

@JsonSerializable()
class RegisterCompany {
  String name;
  RegisterCompany(this.name);

  factory RegisterCompany.fromJson(Map<String, dynamic> json) =>
      _$RegisterCompanyFromJson(json);

  Map<String, dynamic> toJson() => _$RegisterCompanyToJson(this);

  @override
  String toString() {
    return 'RegisterCompany{name: $name}';
  }
}