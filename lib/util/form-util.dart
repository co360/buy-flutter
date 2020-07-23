import 'package:flutter/cupertino.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:storeFlutter/models/search-param.dart';

class FormUtil {
  static FormFieldValidator required(context) {
    return FormBuilderValidators.required(
        errorText: FlutterI18n.translate(context, "error.required"));
  }

  static FormFieldValidator email(context) {
    return FormBuilderValidators.email(
        errorText: FlutterI18n.translate(context, "error.email"));
  }

  static Map<String, dynamic> generateQueryParameters(
    SearchParam param, {
    int page = 0,
    int pageSize = 20,
  }) {
    return {"_pageSize": pageSize, "_page": page};
  }

  static FormFieldValidator pattern(context, pattern, errorMsg) {
    return FormBuilderValidators.pattern(pattern,
        errorText: FlutterI18n.translate(context, errorMsg));
  }

  static FormFieldValidator match(context, fbState, field, errorMsg) {
    String pattern = "";
    if(fbState != null && fbState.value != null && fbState.value[field] != null){
      pattern = fbState.value[field];
    }
    return FormBuilderValidators.pattern(pattern,
        errorText: FlutterI18n.translate(context, errorMsg));
  }
}
