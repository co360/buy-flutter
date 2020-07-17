import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:get_it/get_it.dart';
import 'package:storeFlutter/components/app-button.dart';
import 'package:storeFlutter/services/storage-service.dart';
import 'package:storeFlutter/util/app-theme.dart';

class ShoppingCartScreen extends StatefulWidget {
  @override
  _ShoppingCartScreenState createState() => _ShoppingCartScreenState();
}

class _ShoppingCartScreenState extends State<ShoppingCartScreen> {
  @override
  Widget build(BuildContext context) {
    StorageService storageService = GetIt.I<StorageService>();
    return Scaffold(
      backgroundColor: AppTheme.colorBg2,
      appBar: AppBar(
        title: I18nText(
          "screen.bottomNavigation.cart",
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
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            Text(" ${storageService.accessToken}"),
            Text("${storageService.refreshToken}"),
            Text("${storageService.language}"),
            Text("${storageService.loginUser}"),
            Text("${storageService.loginCompany}"),
            AppButton("Refresh", () {
              setState(() {});
            })
          ],
        ),
      ),
    );
  }
}
