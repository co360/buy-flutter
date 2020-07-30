// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order-rate-review.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderRateReview _$OrderRateReviewFromJson(Map<String, dynamic> json) {
  return OrderRateReview(
    id: json['id'] as int,
    productQuality: json['productQuality'] as int,
    onTimeDelivery: json['onTimeDelivery'] as int,
    service: json['service'] as int,
    easeOfDoingBusiness: json['easeOfDoingBusiness'] as int,
    averageRating: json['averageRating'] as double,
    title: json['title'] as String,
    review: json['review'] as String,
    dateCreated: json['dateCreated'] == null
        ? null
        : LocalDate.fromJson(json['dateCreated'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$OrderRateReviewToJson(OrderRateReview instance) =>
    <String, dynamic>{
      'id': instance.id,
      'productQuality': instance.productQuality,
      'onTimeDelivery': instance.onTimeDelivery,
      'service': instance.service,
      'easeOfDoingBusiness': instance.easeOfDoingBusiness,
      'averageRating': instance.averageRating,
      'title': instance.title,
      'review': instance.review,
      'dateCreated': instance.dateCreated,
    };
