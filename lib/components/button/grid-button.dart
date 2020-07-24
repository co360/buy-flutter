import 'package:flutter/material.dart';
import 'package:storeFlutter/util/app-theme.dart';

class GridButton extends StatelessWidget {
  final String title;
  final VoidCallback cb;

  GridButton({@required this.title, this.cb});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.30,
      height: 65,
      child: FlatButton(
        color: AppTheme.colorBg2,
        textColor: Colors.black,
        padding: EdgeInsets.all(8.0),
        onPressed: () => cb(),
        child: Text(
          title,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 12.0,
            fontWeight: FontWeight.normal,
            color: Colors.black,
          ),
        ),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
  }
}
