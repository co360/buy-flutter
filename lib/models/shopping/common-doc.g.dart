// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'common-doc.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CommonDoc _$CommonDocFromJson(Map<String, dynamic> json) {
  return CommonDoc(
    soldToCustomerID: json['soldToCustomerID'] as int,
    paymentMethod: json['paymentMethod'] as String,
    paymentTerm: json['paymentTerm'] as String,
    salesType: json['salesType'] as String,
    contractQuantityType: json['contractQuantityType'] as String,
    promoDoc: json['promoDoc'] as bool,
    advancedContract: json['advancedContract'] as bool,
    sellerCompanyName: json['sellerCompanyName'] as String,
  );
}

Map<String, dynamic> _$CommonDocToJson(CommonDoc instance) => <String, dynamic>{
      'soldToCustomerID': instance.soldToCustomerID,
      'paymentMethod': instance.paymentMethod,
      'paymentTerm': instance.paymentTerm,
      'salesType': instance.salesType,
      'contractQuantityType': instance.contractQuantityType,
      'promoDoc': instance.promoDoc,
      'advancedContract': instance.advancedContract,
      'sellerCompanyName': instance.sellerCompanyName,
    };
