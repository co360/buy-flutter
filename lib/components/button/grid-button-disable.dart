import 'package:flutter/material.dart';

class GridButtonDisable extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.30,
      child: ConstrainedBox(
        constraints: BoxConstraints(
          minHeight: 65,
        ),
        child: FlatButton(
          onPressed: () => {},
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
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        ),
      ),
    );
  }
}
