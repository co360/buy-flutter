import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:storeFlutter/components/account/check-session.dart';
import 'package:storeFlutter/util/app-theme.dart';

class OrdersScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          FlutterI18n.translate(context, "screen.bottomNavigation.orders"),
          style: TextStyle(color: Colors.white),
        ),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: <Color>[AppTheme.colorPrimary, AppTheme.colorSuccess],
            ),
          ),
        ),
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: CheckSession(child: buildContent()),
    );
  }

  Widget buildContent() {
    return Text("order contents here");
  }
}
