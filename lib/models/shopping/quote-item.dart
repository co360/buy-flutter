import 'package:json_annotation/json_annotation.dart';
import 'package:storeFlutter/models/date-type.dart';
import 'package:storeFlutter/models/shopping/characteristic-value.dart';
import 'package:storeFlutter/models/shopping/common-item.dart';
import 'package:storeFlutter/models/shopping/delivery-schedule.dart';
import 'package:storeFlutter/models/shopping/product.dart';
import 'package:storeFlutter/models/shopping/sku.dart';

part 'quote-item.g.dart';

@JsonSerializable()
class QuoteItem extends CommonItem {
  String additionalInfo;
  bool checked = true;

  //Transient
  List<DeliverySchedule> deliverySchedules;
  //Transient
  LocalDateTime productLeadTime;

  //Transient
  double minOrderQty;
  double maxOrderQty;
  bool decreaseButtonEnable = false;
  bool increaseButtonEnable = true;

  QuoteItem(
      {this.additionalInfo,
      this.checked,
      this.deliverySchedules,
      this.productLeadTime,
      this.minOrderQty,
      this.maxOrderQty,
      this.decreaseButtonEnable,
      this.increaseButtonEnable});

  factory QuoteItem.fromJson(Map<String, dynamic> json) =>
      _$QuoteItemFromJson(json);

  Map<String, dynamic> toJson() => _$QuoteItemToJson(this);
}
