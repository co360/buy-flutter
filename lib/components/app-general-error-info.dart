import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:storeFlutter/util/app-theme.dart';

class AppGeneralErrorInfo extends StatelessWidget {
  final String error;

  const AppGeneralErrorInfo(
    this.error, {
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(AppTheme.paddingStandard),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Center(
            child: FaDuotoneIcon(
              FontAwesomeIcons.duotoneExclamationCircle,
              secondaryColor: AppTheme.colorGray6,
              primaryColor: AppTheme.colorGray6.withOpacity(0.4),
              size: 40,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Center(
            child: Text(
              "Error retrieving : $error",
              textAlign: TextAlign.center,
              style: TextStyle(color: AppTheme.colorGray6),
            ),
          ),
        ],
      ),
    );
  }
}
