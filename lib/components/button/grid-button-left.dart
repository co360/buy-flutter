import 'package:flutter/material.dart';
import 'package:storeFlutter/util/app-theme.dart';

class GridButtonLeft extends StatelessWidget {
  final bool isActive;
  final String title;
  final VoidCallback cb;

  GridButtonLeft({@required this.title, this.cb, this.isActive});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.30,
      height: 65,
      child: FlatButton(
        color: isActive ? Colors.white : AppTheme.colorBg2,
        textColor: Colors.black,
        padding: EdgeInsets.all(8.0),
        onPressed: () => cb(),
        child: Text(
          title,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 14.0,
            fontWeight: FontWeight.normal,
            color: Colors.black,
          ),
        ),
        shape: Border(
          top: BorderSide(width: 0.5, color: AppTheme.colorGray3),
          left: BorderSide(width: 1.0, color: AppTheme.colorGray3),
          right: BorderSide(
              width: 1.0, color: isActive ? Colors.white : AppTheme.colorGray3),
          bottom: BorderSide(width: 0.5, color: AppTheme.colorGray3),
        ),
      ),
    );
  }
}
