import 'package:flutter/cupertino.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_i18n/flutter_i18n.dart';

class FormUtil {
  static FormFieldValidator required(context) {
    return FormBuilderValidators.required(
        errorText: FlutterI18n.translate(context, "error.required"));
  }

  static FormFieldValidator email(context) {
    return FormBuilderValidators.email(
        errorText: FlutterI18n.translate(context, "error.email"));
  }
}
