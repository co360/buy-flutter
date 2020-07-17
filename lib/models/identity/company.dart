import 'package:json_annotation/json_annotation.dart';

part 'company.g.dart';

@JsonSerializable()
class Company {
  int id;
  String name;
  String address1;
  String address2;
  String address3;
  String generalLine;
  String faxNumber;
  String timeZone;
  String countryName;
  String country;
  String servicePackage;
  String website;
  String adminEmail;
  String type;
  String uuid;
//  image: Image;
  String industry;
  String totalEmployees;
  String yearRegistered;

//  suppliers: Company[];
//  businessType: string[];
//  businessActivity: string[];
//  businessModel;
//  subsidiaries: Subsidiary[] = [];
//  productCategories: string[] = [];
//  shipToCustomer: ShipToCustomer[] = [];
//  rfqSuppliers: string[] = [];
//  infoCompleted;

  String postcode;
  String state;
  String city;
  String otherIdNo;

  Company(
      this.id,
      this.name,
      this.address1,
      this.address2,
      this.address3,
      this.generalLine,
      this.faxNumber,
      this.timeZone,
      this.countryName,
      this.country,
      this.servicePackage,
      this.website,
      this.adminEmail,
      this.type,
      this.uuid,
      this.industry,
      this.totalEmployees,
      this.yearRegistered,
      this.postcode,
      this.state,
      this.city,
      this.otherIdNo);

  factory Company.fromJson(Map<String, dynamic> json) =>
      _$CompanyFromJson(json);

  Map<String, dynamic> toJson() => _$CompanyToJson(this);
}
