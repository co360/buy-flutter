import 'package:json_annotation/json_annotation.dart';
import 'package:storeFlutter/models/local-date.dart';

part 'order-rate-review.g.dart';

@JsonSerializable()
class OrderRateReview {
  int id;
  int productQuality;
  int onTimeDelivery;
  int service;
  int easeOfDoingBusiness;
  double averageRating;
  String title;
  String review;
  // salesOrder: SalesOrder;
  LocalDate dateCreated;

  OrderRateReview(
      {this.id,
      this.productQuality,
      this.onTimeDelivery,
      this.service,
      this.easeOfDoingBusiness,
      this.averageRating,
      this.title,
      this.review,
      this.dateCreated});

  factory OrderRateReview.fromJson(Map<String, dynamic> json) =>
      _$OrderRateReviewFromJson(json);

  Map<String, dynamic> toJson() => _$OrderRateReviewToJson(this);
}
