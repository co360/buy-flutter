import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:storeFlutter/util/app-theme.dart';

class AppButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final bool noPadding;
  final double bottomPadding;

  final Widget widget;

  final AppButtonType type;
  final AppButtonSize size;

  const AppButton(this.text, this.onPressed,
      {this.type = AppButtonType.orange,
      this.widget,
      this.noPadding = false,
      this.bottomPadding = AppTheme.paddingStandard,
      this.size = AppButtonSize.big});

  const AppButton.widget(this.widget, this.onPressed,
      {this.type = AppButtonType.orange,
      this.text,
      this.noPadding = false,
      this.bottomPadding = AppTheme.paddingStandard,
      this.size = AppButtonSize.big});

  @override
  Widget build(BuildContext context) {
    double fontSize = 17;
    EdgeInsets padding = EdgeInsets.symmetric(vertical: 14, horizontal: 20);

    if (this.size == AppButtonSize.small) {
      fontSize = 14;
      padding = EdgeInsets.symmetric(vertical: 11, horizontal: 20);
    }

    return Padding(
      padding: EdgeInsets.only(bottom: this.noPadding ? 0 : this.bottomPadding),
      child: RaisedButton(
        onPressed: this.onPressed,
        color: this.type.backgroundColor,
        elevation: 3,
        padding: padding,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(80.0),
        ),
        child: widget != null
            ? widget
            : AutoSizeText(this.text,
                minFontSize: 12,
                style: TextStyle(
                  color: this.type.textColor,
                  fontSize: fontSize,
                  fontWeight: FontWeight.bold,
                )),
      ),
    );
  }
}

enum AppButtonSize { big, small }

enum AppButtonType { success, white, orange }

extension TypeExtension on AppButtonType {
  Color get backgroundColor {
    switch (this) {
      case AppButtonType.orange:
        return AppTheme.colorOrange;
      case AppButtonType.white:
        return Colors.white;
      case AppButtonType.success:
        return AppTheme.colorSuccess;
      default:
        return AppTheme.colorOrange;
    }
  }

  Color get textColor {
    switch (this) {
      case AppButtonType.white:
        return AppTheme.colorLink;
      default:
        return Colors.white;
    }
  }
}
