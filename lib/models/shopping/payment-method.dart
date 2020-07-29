import 'package:json_annotation/json_annotation.dart';

part 'payment-method.g.dart';

@JsonSerializable()
class PaymentMethod {
  int paymentMethodID;
  String code;
  String name;

  PaymentMethod({this.paymentMethodID, this.code, this.name});

  factory PaymentMethod.fromJson(Map<String, dynamic> json) =>
      _$PaymentMethodFromJson(json);

  Map<String, dynamic> toJson() => _$PaymentMethodToJson(this);
}
