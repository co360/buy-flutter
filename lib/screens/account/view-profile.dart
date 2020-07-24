import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:get_it/get_it.dart';
import 'package:storeFlutter/components/app-list-tile-two-cols.dart';
import 'package:storeFlutter/services/storage-service.dart';
import 'package:storeFlutter/util/app-theme.dart';
import 'package:storeFlutter/screens/account/edit-profile.dart';

class ViewProfileScreen extends StatefulWidget {
  @override
  _ViewProfileScreenState createState() => _ViewProfileScreenState();
}

class _ViewProfileScreenState extends State<ViewProfileScreen> {
  final StorageService storageService = GetIt.I<StorageService>();

  @override
  void initState() {
    print("Initialize ViewProfileScreen Screen and State");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: I18nText("account.myProfile"),
        actions: <Widget>[
          FlatButton(
            textColor: AppTheme.colorLink,
            onPressed: () => {
              Navigator.push(
                context,
                CupertinoPageRoute(
                  builder: (context) => EditProfileScreen(),
                ),
              )
            },
            child: Text(FlutterI18n.translate(context, "account.edit")),
            shape: CircleBorder(side: BorderSide(color: Colors.transparent)),
          ),
        ],
      ),
      body: SafeArea(
        child: GestureDetector(
          onTap: () => {FocusScope.of(context).requestFocus(new FocusNode())},
          behavior: HitTestBehavior.translucent,
          child: LayoutBuilder(
            builder:
                (BuildContext context, BoxConstraints viewportConstraints) {
              return Container(
                padding: const EdgeInsets.only(top: 20.0),
                child: ListView(children: <Widget>[
                  AppListTileTwoCols(
                      FlutterI18n.translate(context, "account.name"),
                      storageService.loginUser.name),
                  AppListTileTwoCols(
                      FlutterI18n.translate(context, "account.mobileContact"),
                      storageService.loginUser.contactNo),
                ]),
              );
            },
          ),
        ),
      ),
    );
  }
}
