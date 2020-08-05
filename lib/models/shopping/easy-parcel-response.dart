import 'package:json_annotation/json_annotation.dart';
import 'package:storeFlutter/models/date-type.dart';

part 'easy-parcel-response.g.dart';

@JsonSerializable()
class EasyParcelResponse {
  int id;
  String source;
  String rate_id;
  String service_id;
  String service_name;
  String service_type;
  String courier_id;
  String courier_name;
  String courier_logo;
  String scheduled_start_date;
  LocalDate pickup_date;
  String delivery;
  LocalDateRange delivery_dates;
  double price;

  EasyParcelResponse(
      {this.id,
      this.source,
      this.rate_id,
      this.service_id,
      this.service_name,
      this.service_type,
      this.courier_id,
      this.courier_name,
      this.courier_logo,
      this.scheduled_start_date,
      this.pickup_date,
      this.delivery,
      this.delivery_dates,
      this.price});

  factory EasyParcelResponse.fromJson(Map<String, dynamic> json) =>
      _$EasyParcelResponseFromJson(json);

  Map<String, dynamic> toJson() => _$EasyParcelResponseToJson(this);
}
