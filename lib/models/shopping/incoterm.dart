import 'package:json_annotation/json_annotation.dart';

part 'incoterm.g.dart';

@JsonSerializable()
class Incoterm {
  int incotermID;
  String code;
  String name;

  Incoterm({this.incotermID, this.code, this.name});

  factory Incoterm.fromJson(Map<String, dynamic> json) =>
      _$IncotermFromJson(json);

  Map<String, dynamic> toJson() => _$IncotermToJson(this);
}
