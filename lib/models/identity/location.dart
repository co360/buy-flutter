import 'package:json_annotation/json_annotation.dart';

part 'location.g.dart';

@JsonSerializable()
class Location {
  int id;
  String name;
  String code;
  double latitude;
  double longitude;
  String address;
  String countryCode;
  String nearestPortCountry;
  String portCode;
  bool deliveryLocation;
  bool supplyLocation;
  String postcode;
  String state;
  String city;

  //transient fields
  String portName;
  String countryName;

  Location(
      {this.id,
      this.name,
      this.code,
      this.latitude,
      this.longitude,
      this.address,
      this.countryCode,
      this.nearestPortCountry,
      this.portCode,
      this.deliveryLocation,
      this.supplyLocation,
      this.postcode,
      this.state,
      this.city,
      this.portName,
      this.countryName});

  factory Location.fromJson(Map<String, dynamic> json) =>
      _$LocationFromJson(json);

  Map<String, dynamic> toJson() => _$LocationToJson(this);
}
