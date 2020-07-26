import 'package:json_annotation/json_annotation.dart';

part 'lst-function.g.dart';

@JsonSerializable()
class LstFunction {
  int functionID;
  String microService;
  String module;
  String clientAccess;
  String serverUrl;
  String description;
  String httpMethod;

  LstFunction(this.functionID, this.microService, this.module,
      this.clientAccess, this.serverUrl, this.description, this.httpMethod);

  factory LstFunction.fromJson(Map<String, dynamic> json) =>
      _$LstFunctionFromJson(json);

  Map<String, dynamic> toJson() => _$LstFunctionToJson(this);
}
