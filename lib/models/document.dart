import 'package:json_annotation/json_annotation.dart';
import 'package:storeFlutter/models/date-type.dart';
import 'package:storeFlutter/models/label-value.dart';

part 'document.g.dart';

@JsonSerializable()
class Document {
  String documentName;
  String filename;
  String documentUrl;
  int fileSize;
  String status;
  LocalDateTime uploadTime;
  String uploadUser;
  String contentType;
  List<LabelValue> scannedTexts;

  Document(
      this.documentName,
      this.filename,
      this.documentUrl,
      this.fileSize,
      this.status,
      this.uploadTime,
      this.uploadUser,
      this.contentType,
      this.scannedTexts);

  factory Document.fromJson(Map<String, dynamic> json) =>
      _$DocumentFromJson(json);

  Map<String, dynamic> toJson() => _$DocumentToJson(this);
}
