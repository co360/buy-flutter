import 'package:json_annotation/json_annotation.dart';
import 'package:storeFlutter/models/identity/department.dart';
import 'package:storeFlutter/models/identity/designation.dart';

part 'account.g.dart';

@JsonSerializable()
class Account {
  int id;
  String userName;

//  String password;
  String name;
  String lastName;
  String firstName;
  Department department;
  Designation designation;
  String email;
  String recoveryEmail;
  String contactNo;
  String country;
  String cityState;
  String timezone;
//  bool passwordReset;
  int reportTo;
  String linkedIn;
//  profilePic: Image;
  int status;
  String division;
  String jobTitle;

  Account(
      this.id,
      this.userName,
//      this.password,
      this.name,
      this.lastName,
      this.firstName,
//      this.department,
//      this.designation,
      this.email,
      this.recoveryEmail,
      this.contactNo,
      this.country,
      this.cityState,
      this.timezone,
//      this.passwordReset,
      this.reportTo,
      this.linkedIn,
      this.status,
      this.division,
      this.jobTitle);
//  roles: Role[];

  factory Account.fromJson(Map<String, dynamic> json) =>
      _$AccountFromJson(json);

  Map<String, dynamic> toJson() => _$AccountToJson(this);
}
