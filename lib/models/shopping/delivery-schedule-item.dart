import 'package:json_annotation/json_annotation.dart';

part 'delivery-schedule-item.g.dart';

@JsonSerializable()
class DeliveryScheduleItem {
  double quantity;
  String itemNumber;

  DeliveryScheduleItem({this.quantity, this.itemNumber});

  factory DeliveryScheduleItem.fromJson(Map<String, dynamic> json) =>
      _$DeliveryScheduleItemFromJson(json);

  Map<String, dynamic> toJson() => _$DeliveryScheduleItemToJson(this);
}
