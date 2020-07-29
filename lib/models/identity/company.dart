import 'package:json_annotation/json_annotation.dart';
import 'package:storeFlutter/models/image.dart';

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
  Image image;
  String industry;
  String totalEmployees;
  String yearRegistered;

//  suppliers: Company[];
  List<String> businessType;
  List<String> businessActivity;
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
      this.image,
      this.industry,
      this.totalEmployees,
      this.yearRegistered,
      this.businessType,
      this.businessActivity,
      this.postcode,
      this.state,
      this.city,
      this.otherIdNo);

  factory Company.fromJson(Map<String, dynamic> json) =>
      _$CompanyFromJson(json);

  Map<String, dynamic> toJson() => _$CompanyToJson(this);
}
