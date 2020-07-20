import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:storeFlutter/util/app-theme.dart';

class ShoppingCartIcon extends StatelessWidget {
  final double iconPaddingHeight = 5;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () => _tap(context),
      child: Stack(
        children: <Widget>[
          Column(
            children: <Widget>[
              SizedBox(
                height: iconPaddingHeight,
              ),
              Padding(
                padding: EdgeInsets.only(right: 5),
                child: FaIcon(
                  FontAwesomeIcons.lightShoppingCart,
                  color: Colors.white,
                  size: 25,
                ),
              ),
              SizedBox(
                height: iconPaddingHeight,
              ),
            ],
          ),
          Positioned(
            right: 0,
            child: Container(
              decoration: BoxDecoration(
                color: AppTheme.colorOrange,
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 2, horizontal: 6.0),
                child: Text(
                  "2",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 11,
                      fontWeight: FontWeight.w500),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  void _tap(BuildContext context) {
    Navigator.of(context).pushNamed("/cart");
  }
}
