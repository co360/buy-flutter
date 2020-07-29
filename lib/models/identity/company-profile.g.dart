// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'company-profile.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CompanyProfile _$CompanyProfileFromJson(Map<String, dynamic> json) {
  return CompanyProfile(
    json['id'] as int,
    (json['videos'] as List)
        ?.map((e) =>
            e == null ? null : Document.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    (json['taxCertificates'] as List)
        ?.map((e) =>
            e == null ? null : Document.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    (json['registrationDocuements'] as List)
        ?.map((e) =>
            e == null ? null : Document.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    json['businessNature'] as String,
    (json['paidUpCapital'] as num)?.toDouble(),
    json['currencyCode'] as String,
    (json['locations'] as List)
        ?.map((e) =>
            e == null ? null : Location.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    (json['annualReports'] as List)
        ?.map((e) =>
            e == null ? null : Document.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    (json['otherCertificates'] as List)
        ?.map((e) =>
            e == null ? null : Document.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    json['certified'] as bool,
    json['agreed'] as bool,
    json['companyId'] as int,
    json['totalAnnualRevenue'] as String,
    json['longIntroduction'] as String,
    json['credential'] as String,
    (json['incoterms'] as List)?.map((e) => e as String)?.toList(),
    (json['paymentTerms'] as List)?.map((e) => e as String)?.toList(),
    (json['paymentMethods'] as List)?.map((e) => e as String)?.toList(),
    (json['paymentTermsProspect'] as List)?.map((e) => e as String)?.toList(),
    (json['paymentMethodsProspect'] as List)?.map((e) => e as String)?.toList(),
    json['salesTermCondition'] == null
        ? null
        : Document.fromJson(json['salesTermCondition'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$CompanyProfileToJson(CompanyProfile instance) =>
    <String, dynamic>{
      'id': instance.id,
      'videos': instance.videos,
      'taxCertificates': instance.taxCertificates,
      'registrationDocuements': instance.registrationDocuements,
      'businessNature': instance.businessNature,
      'paidUpCapital': instance.paidUpCapital,
      'currencyCode': instance.currencyCode,
      'locations': instance.locations,
      'annualReports': instance.annualReports,
      'otherCertificates': instance.otherCertificates,
      'certified': instance.certified,
      'agreed': instance.agreed,
      'companyId': instance.companyId,
      'totalAnnualRevenue': instance.totalAnnualRevenue,
      'longIntroduction': instance.longIntroduction,
      'credential': instance.credential,
      'incoterms': instance.incoterms,
      'paymentTerms': instance.paymentTerms,
      'paymentMethods': instance.paymentMethods,
      'paymentTermsProspect': instance.paymentTermsProspect,
      'paymentMethodsProspect': instance.paymentMethodsProspect,
      'salesTermCondition': instance.salesTermCondition,
    };
