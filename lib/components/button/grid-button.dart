import 'package:flutter/material.dart';

class GridButton extends StatelessWidget {
  final String title;
  final VoidCallback cb;

  GridButton({@required this.title, this.cb});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 86,
      height: 65,
      child: FlatButton(
        color: Color(int.parse("0xFFF3F5F8")),
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
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
  }
}
