// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sales-cart.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SalesCart _$SalesCartFromJson(Map<String, dynamic> json) {
  return SalesCart(
    id: json['id'] as int,
    accountId: json['accountId'] as int,
    dateCreated: json['dateCreated'] == null
        ? null
        : LocalDate.fromJson(json['dateCreated'] as Map<String, dynamic>),
    cartDocs: (json['cartDocs'] as List)
        ?.map((e) => e == null
            ? null
            : SalesQuotation.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$SalesCartToJson(SalesCart instance) => <String, dynamic>{
      'id': instance.id,
      'accountId': instance.accountId,
      'dateCreated': instance.dateCreated,
      'cartDocs': instance.cartDocs,
    };
