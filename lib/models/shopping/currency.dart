import 'package:json_annotation/json_annotation.dart';

part 'currency.g.dart';

@JsonSerializable()
class Currency {
  int currencyID;
  String code;
  String name;
  String shortName;
  String suffix;
  String prefix;

  Currency(
      {this.currencyID,
      this.code,
      this.name,
      this.shortName,
      this.suffix,
      this.prefix});

  factory Currency.fromJson(Map<String, dynamic> json) =>
      _$CurrencyFromJson(json);

  Map<String, dynamic> toJson() => _$CurrencyToJson(this);
}
