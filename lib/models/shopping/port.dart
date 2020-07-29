import 'package:json_annotation/json_annotation.dart';

part 'port.g.dart';

@JsonSerializable()
class Port {
  int portID;
  String code;
  String name;
  String shortName;

  Port({this.portID, this.code, this.name, this.shortName});

  factory Port.fromJson(Map<String, dynamic> json) => _$PortFromJson(json);

  Map<String, dynamic> toJson() => _$PortToJson(this);
}
