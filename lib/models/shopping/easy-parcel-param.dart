import 'package:json_annotation/json_annotation.dart';

part 'easy-parcel-param.g.dart';

@JsonSerializable()
class EasyParcelParam {
  String senderPostcode;
  String senderState;
  String senderCountry;
  String receiverPostcode;
  String receiverState;
  String receiverCountry;
  double weight;
  double length;
  double width;
  double height;

  EasyParcelParam(
      {this.senderPostcode,
      this.senderState,
      this.senderCountry,
      this.receiverPostcode,
      this.receiverState,
      this.receiverCountry,
      this.weight,
      this.length,
      this.width,
      this.height});

  factory EasyParcelParam.fromJson(Map<String, dynamic> json) =>
      _$EasyParcelParamFromJson(json);

  Map<String, dynamic> toJson() => _$EasyParcelParamToJson(this);
}
