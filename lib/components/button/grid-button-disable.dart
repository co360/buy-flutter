import 'package:flutter/material.dart';
import 'package:storeFlutter/util/app-theme.dart';

class GridButtonDisable extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.30,
      height: 65,
      child: FlatButton(
        color: Colors.white,
        textColor: Colors.black,
        padding: EdgeInsets.all(8.0),
        child: Text(
          "",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 14.0,
            fontWeight: FontWeight.normal,
            color: Colors.black,
          ),
        ),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
  }
}
