import 'package:flutter/material.dart';
import 'package:quiver/strings.dart';
import 'package:storeFlutter/util/app-theme.dart';

class AppLabelValue extends StatelessWidget {
  final String label;
  final String value;

  AppLabelValue(this.label, this.value);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Text(label,
            style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 12,
                color: AppTheme.colorGray5)),
        SizedBox(
          height: 8,
        ),
        Text(isNotBlank(value) ? value : "-"),
        SizedBox(
          height: 20,
        ),
      ],
    );
  }
}
