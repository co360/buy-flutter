import 'package:json_annotation/json_annotation.dart';
import 'package:storeFlutter/models/document.dart';
import 'package:storeFlutter/models/identity/location.dart';

part 'company-profile.g.dart';

@JsonSerializable()
class CompanyProfile {
  int id;
  List<Document> videos;
  List<Document> taxCertificates;
  List<Document> registrationDocuements;
  String businessNature;
  double paidUpCapital;
  String currencyCode;
  List<Location> locations;
  List<Document> annualReports;
  List<Document> otherCertificates;
  bool certified;
  bool agreed;
  int companyId;

  String totalAnnualRevenue;
  String longIntroduction;
  String credential;
  List<String> incoterms;
  List<String> paymentTerms;
  List<String> paymentMethods;
  List<String> paymentTermsProspect;
  List<String> paymentMethodsProspect;
//  certificates: Certificate[] = [];
//  allowableIncoterm: AllowableIncoterm[] = [];
  Document salesTermCondition;

  CompanyProfile(
      this.id,
      this.videos,
      this.taxCertificates,
      this.registrationDocuements,
      this.businessNature,
      this.paidUpCapital,
      this.currencyCode,
      this.locations,
      this.annualReports,
      this.otherCertificates,
      this.certified,
      this.agreed,
      this.companyId,
      this.totalAnnualRevenue,
      this.longIntroduction,
      this.credential,
      this.incoterms,
      this.paymentTerms,
      this.paymentMethods,
      this.paymentTermsProspect,
      this.paymentMethodsProspect,
      this.salesTermCondition);

  factory CompanyProfile.fromJson(Map<String, dynamic> json) =>
      _$CompanyProfileFromJson(json);

  Map<String, dynamic> toJson() => _$CompanyProfileToJson(this);
}
