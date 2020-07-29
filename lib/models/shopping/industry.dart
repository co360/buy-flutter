import 'package:json_annotation/json_annotation.dart';

part 'industry.g.dart';

@JsonSerializable()
class Industry {
  int industryID;
  String code;
  String name;

  Industry({this.industryID, this.code, this.name});

  factory Industry.fromJson(Map<String, dynamic> json) =>
      _$IndustryFromJson(json);

  Map<String, dynamic> toJson() => _$IndustryToJson(this);
}
