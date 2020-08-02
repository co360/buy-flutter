import 'package:json_annotation/json_annotation.dart';
import 'package:storeFlutter/models/local-date.dart';
import 'package:storeFlutter/models/shopping/sales-order.dart';

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
  SalesOrder salesOrder;
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
      this.salesOrder,
      this.dateCreated});

  factory OrderRateReview.fromJson(Map<String, dynamic> json) =>
      _$OrderRateReviewFromJson(json);

  Map<String, dynamic> toJson() => _$OrderRateReviewToJson(this);
}
