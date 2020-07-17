import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get_it/get_it.dart';
import 'package:storeFlutter/blocs/language/language-bloc.dart';
import 'package:storeFlutter/components/app-list-title.dart';
import 'package:storeFlutter/util/app-theme.dart';

class ChangeLanguageScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    String currentLang = FlutterI18n.currentLocale(context).languageCode;

    return Scaffold(
      appBar: AppBar(
        title: I18nText("account.changeLanguage"),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          AppListTitle("account.changeLanguageScreen.languages"),
          buildLanguageTile("ms", currentLang, context),
          buildLanguageTile("en", currentLang, context),
        ],
      ),
    );
  }

  LanguageTile buildLanguageTile(
      String code, String currentLang, BuildContext context,
      {topDivider = false}) {
    return LanguageTile(
      "language.$code",
      code == currentLang ? true : false,
      () => {
        GetIt.I<LanguageBloc>().add(ChangeLanguage(context, code)),
        Navigator.of(context).pop()
      },
      topDivider: topDivider,
    );
  }
}

class LanguageTile extends StatelessWidget {
  final VoidCallback onTap;
  final String title;
  final bool topDivider;
  final bool selected;

  LanguageTile(this.title, this.selected, this.onTap, {this.topDivider: false});

  @override
  Widget build(BuildContext context) {
    List<Widget> widgets = [];

    widgets = <Widget>[
      ListTile(
        onTap: onTap,
        trailing: selected
            ? FaIcon(
                FontAwesomeIcons.lightCheck,
                size: 20,
                color: AppTheme.colorLink,
              )
            : null,
        title: I18nText(title),
      ),
      Divider(
        color: AppTheme.colorGray3,
        height: 1,
      )
    ];

    if (topDivider) {
      widgets.insert(
        0,
        Divider(
          color: AppTheme.colorGray3,
          height: 1,
        ),
      );
    }

    return Container(
      color: Colors.white,
      child: Column(
        children: widgets,
      ),
    );
  }
}
