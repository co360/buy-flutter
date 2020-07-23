import 'package:flutter/material.dart';
import 'package:storeFlutter/util/app-theme.dart';

class GridButtonTop extends StatelessWidget {
  final VoidCallback cb;

  GridButtonTop({@required this.cb});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.50,
      height: 36,
      child: FlatButton(
        color: AppTheme.colorGray2,
        textColor: Colors.black,
        // disabledColor: Colors.grey,
        // disabledTextColor: Colors.black,
        padding: EdgeInsets.all(8.0),
        // splashColor: Colors.blueAccent,
        onPressed: () => cb(),
        child: Text(
          "See All Apparel",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 14.0,
            fontWeight: FontWeight.normal,
            color: AppTheme.colorPrimary,
          ),
        ),
        shape: RoundedRectangleBorder(
            // side: BorderSide(
            //     color: Colors.blue, width: 1, style: BorderStyle.solid),
            borderRadius: BorderRadius.circular(10)),
      ),
    );
  }
}
