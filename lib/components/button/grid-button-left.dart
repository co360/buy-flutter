import 'package:flutter/material.dart';

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
        color: isActive
            ? Color(int.parse("0xFFFFFFFF"))
            : Color(int.parse("0xFFF3F5F8")),
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
        shape: RoundedRectangleBorder(
          side: BorderSide(
              color: isActive
                  ? Color(int.parse("0xFFFFFFFF"))
                  : Color(int.parse("0xFFDEE2E6")),
              width: 1,
              style: BorderStyle.solid),
        ),
      ),
    );
  }
}