// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'image.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Image _$ImageFromJson(Map<String, dynamic> json) {
  return Image(
    json['id'] as int,
    json['name'] as String,
    json['small'] as String,
    json['thumbnail'] as String,
    json['large'] as String,
    json['imageUrl'] as String,
  );
}

Map<String, dynamic> _$ImageToJson(Image instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'small': instance.small,
      'thumbnail': instance.thumbnail,
      'large': instance.large,
      'imageUrl': instance.imageUrl,
    };
