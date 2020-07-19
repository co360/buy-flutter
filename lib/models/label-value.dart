import 'package:json_annotation/json_annotation.dart';

part 'label-value.g.dart';

@JsonSerializable()
class LabelValue {
  String label;
  String label2;
  String label3;
  String label4;
  String value;
  String code;

  LabelValue(
      this.label, this.label2, this.label3, this.label4, this.value, this.code);

  factory LabelValue.fromJson(Map<String, dynamic> json) =>
      _$LabelValueFromJson(json);

  Map<String, dynamic> toJson() => _$LabelValueToJson(this);
}
