import 'package:json_annotation/json_annotation.dart';

part 'response-object.g.dart';

class ResponseObject<T> {
  T object;
  List<ResponseMessage> messages;

  ResponseObject(this.object, this.messages);

//  factory ResponseObject.fromJson(Map<String, dynamic> json) =>
//      _$ResponseObjectFromJson(json);

  factory ResponseObject.fromJson(
      Map<String, dynamic> json, [Function(Map<String, dynamic>) objFromJson]) {

    if(json == null) {
      return null;
    }

    var results;
    final items = json['object'];

    //TODO: handle method not found json
    final error = json['error'];
    if(error != null) {
      ResponseMessage msg = ResponseMessage("ERROR", json['message']);
      List<ResponseMessage> msgList = [msg];
      return ResponseObject<T>(results, msgList);
    }

    // TODO: handle list object
    if(items != null && objFromJson != null) {
      if (T is List) {
        results =
            items.map((e) => e == null ? null : objFromJson(e)).toList();
      } else {
        final target = items == null ? Map<String, dynamic>.from({}) : Map<String, dynamic>.from(items);
        results = objFromJson(target);
      }
    }

    final messages = json['messages'] != null? json['messages'].map((e) => e == null
            ? null
            : ResponseMessage.fromJson(e as Map<String, dynamic>))
        .toList()
        .cast<ResponseMessage>() : null;

    return ResponseObject<T>(results, messages);
  }
}

@JsonSerializable()
class ResponseMessage {
  String type;
  String message;

  ResponseMessage(this.type, this.message);

  factory ResponseMessage.fromJson(Map<String, dynamic> json) =>
      _$ResponseMessageFromJson(json);

  Map<String, dynamic> toJson() => _$ResponseMessageToJson(this);
}
