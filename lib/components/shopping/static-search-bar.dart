import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:quiver/strings.dart';
import 'package:storeFlutter/models/shopping/product.dart';
import 'package:storeFlutter/screens/shopping/search-general.dart';
import 'package:storeFlutter/util/app-theme.dart';

class StaticSearchBar extends StatelessWidget {
  final String placeholder;
  final String query;
  final Color borderColor;

  const StaticSearchBar({
    this.placeholder,
    this.query,
    this.borderColor,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _tap(context),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(5)),
          border: borderColor != null
              ? Border.all(color: borderColor, width: 1)
              : null,
        ),
        padding: EdgeInsets.symmetric(vertical: 8, horizontal: 10),
        child: Row(
          children: <Widget>[
            FaIcon(
              FontAwesomeIcons.lightSearch,
              color: AppTheme.colorOrange,
              size: 20,
            ),
            SizedBox(
              width: 10,
            ),
            Expanded(
              child: Text(
                isNotBlank(query) ? query : placeholder,
                style: TextStyle(
                    color: AppTheme.colorGray5,
                    fontSize: 14,
                    fontWeight: FontWeight.normal),
              ),
            )
          ],
        ),
      ),
    );
  }

  void _tap(BuildContext context) {
//    setState(() {
//
//    });
    Navigator.of(context).push(PageRouteBuilder(
      fullscreenDialog: true,
      opaque: false,
      pageBuilder: (BuildContext context, _, __) => SearchGeneral(
        query: query,
        placeholder: placeholder,
      ),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        var begin = Offset(0.0, 1.0);
        var end = Offset.zero;
        var curve = Curves.ease;

        var tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
    ));
  }
}
