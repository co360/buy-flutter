import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:get_it/get_it.dart';
import 'package:storeFlutter/blocs/language/language_bloc.dart';
import 'package:storeFlutter/util/app-theme.dart';

class AccountScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.colorBg2,
      appBar: AppBar(
        title: I18nText(
          "label.main",
          translationParams: {"user": "Yoke Harn"},
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
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              RaisedButton(
                key: Key('changeLanguage'),
                onPressed: () async {
                  GetIt.I<LanguageBloc>().add(SwitchLanguage(context));
                },
                child: Text(
                  FlutterI18n.translate(context, "button.label.switchLanguage"),
                ),
              ),
              I18nText("button.label.language"),
            ],
          ),
        ),
      ),
    );
  }
}
