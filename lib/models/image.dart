import 'package:json_annotation/json_annotation.dart';

part 'image.g.dart';

@JsonSerializable()
class Image {
  int id;
  String name;
  String small;
  String thumbnail;
  String large;
  String imageUrl;

  Image(this.id, this.name, this.small, this.thumbnail, this.large,
      this.imageUrl);

  factory Image.fromJson(Map<String, dynamic> json) => _$ImageFromJson(json);

  Map<String, dynamic> toJson() => _$ImageToJson(this);
}
