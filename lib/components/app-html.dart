import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_html/style.dart';
import 'package:storeFlutter/util/resource-util.dart';

class AppHtml extends StatelessWidget {
  final String html;

  AppHtml(this.html);

  @override
  Widget build(BuildContext context) {
    return Html(
      data: ResourceUtil.fullPathImageHtml(html),
      style: {
        "body": Style(
          margin: EdgeInsets.zero,
        ),
        "p": Style(
          margin: EdgeInsets.only(bottom: 10),
        ),
      },
    );
  }
}
