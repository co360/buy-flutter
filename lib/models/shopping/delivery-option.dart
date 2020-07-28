import 'package:json_annotation/json_annotation.dart';
import 'package:storeFlutter/models/identity/location.dart';

part 'delivery-option.g.dart';

@JsonSerializable()
class DeliveryOption extends Location {
  String portName;
  String portAddress;
  String countryName;
  String nearestPortCountryName;
  bool toPort;
  bool toBuyer;
  String imageUrl;

  bool selected = false;
  bool defaultSupplyLocation = false;
  bool newLocation = false;

  DeliveryOption(
      {this.portName,
      this.portAddress,
      this.countryName,
      this.nearestPortCountryName,
      this.toPort,
      this.toBuyer,
      this.imageUrl,
      this.selected,
      this.defaultSupplyLocation,
      this.newLocation});

  factory DeliveryOption.fromJson(Map<String, dynamic> json) =>
      _$DeliveryOptionFromJson(json);

  Map<String, dynamic> toJson() => _$DeliveryOptionToJson(this);
}
