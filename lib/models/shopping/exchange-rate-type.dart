import 'package:json_annotation/json_annotation.dart';

part 'exchange-rate-type.g.dart';

@JsonSerializable()
class ExchangeRateType {
  int exchangeRateTypeID;
  String code;
  String name;

  int companyId;

  ExchangeRateType(
      {this.exchangeRateTypeID, this.code, this.name, this.companyId});

  factory ExchangeRateType.fromJson(Map<String, dynamic> json) =>
      _$ExchangeRateTypeFromJson(json);

  Map<String, dynamic> toJson() => _$ExchangeRateTypeToJson(this);
}
