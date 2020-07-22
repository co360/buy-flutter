// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'document.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Document _$DocumentFromJson(Map<String, dynamic> json) {
  return Document(
    json['documentName'] as String,
    json['filename'] as String,
    json['documentUrl'] as String,
    json['fileSize'] as int,
    json['status'] as String,
    json['uploadTime'] == null
        ? null
        : LocalDateTime.fromJson(json['uploadTime'] as Map<String, dynamic>),
    json['uploadUser'] as String,
    json['contentType'] as String,
    (json['scannedTexts'] as List)
        ?.map((e) =>
            e == null ? null : LabelValue.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$DocumentToJson(Document instance) => <String, dynamic>{
      'documentName': instance.documentName,
      'filename': instance.filename,
      'documentUrl': instance.documentUrl,
      'fileSize': instance.fileSize,
      'status': instance.status,
      'uploadTime': instance.uploadTime,
      'uploadUser': instance.uploadUser,
      'contentType': instance.contentType,
      'scannedTexts': instance.scannedTexts,
    };
