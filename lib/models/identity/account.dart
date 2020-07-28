import 'package:json_annotation/json_annotation.dart';
import 'package:storeFlutter/models/identity/department.dart';
import 'package:storeFlutter/models/identity/designation.dart';
import 'package:storeFlutter/models/identity/role.dart';
import 'package:storeFlutter/models/identity/image.dart';

part 'account.g.dart';

@JsonSerializable()
class Account {
  int id;
  int companyId;
  String userName;
  String password;
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
  bool passwordReset;
  int reportTo;
  String linkedIn;
  Image profilePic;
  int status;
  String division;
  String jobTitle;
  List<Role> roles;
  String accountType;
  bool isMember;

  Account(
    this.id,
    this.userName,
    this.password,
    this.name,
    this.lastName,
    this.firstName,
    this.department,
    this.designation,
    this.email,
    this.recoveryEmail,
    this.contactNo,
    this.country,
    this.cityState,
    this.timezone,
    this.passwordReset,
    this.reportTo,
    this.linkedIn,
    this.status,
    this.division,
    this.jobTitle,
    this.roles,
    this.accountType,
    this.isMember,
  );

  factory Account.fromJson(Map<String, dynamic> json) =>
      _$AccountFromJson(json);

  Map<String, dynamic> toJson() => _$AccountToJson(this);
}
