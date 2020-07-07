import 'package:flutter/material.dart';
import 'package:storeFlutter/util/app-theme.dart';

class AppButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final bool noPadding;

  final Type type;

  const AppButton(this.text, this.onPressed,
      {this.type = Type.orange, this.noPadding = false});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
          bottom: this.noPadding ? 0 : AppTheme.paddingStandard),
      child: RaisedButton(
        onPressed: this.onPressed,
        color: this.type.backgroundColor,
        elevation: 3,
        padding: EdgeInsets.symmetric(vertical: 14, horizontal: 20),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(80.0),
        ),
        child: Text(this.text,
            style: TextStyle(
              color: this.type.textColor,
              fontSize: 17,
              fontWeight: FontWeight.bold,
            )),
      ),
    );
  }
}

enum Type { success, white, orange }

extension TypeExtension on Type {
  Color get backgroundColor {
    switch (this) {
      case Type.orange:
        return AppTheme.colorOrange;
      case Type.white:
        return Colors.white;
      case Type.success:
        return AppTheme.colorSuccess;
      default:
        return AppTheme.colorOrange;
    }
  }

  Color get textColor {
    switch (this) {
      case Type.white:
        return AppTheme.colorPrimary;
      default:
        return Colors.white;
    }
  }
}
