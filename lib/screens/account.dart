import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:storeFlutter/components/app_button.dart';
import 'package:storeFlutter/components/app_list_tile.dart';
import 'package:storeFlutter/components/app_list_title.dart';
import 'package:storeFlutter/screens/account/change_language.dart';
import 'package:storeFlutter/util/app-theme.dart';

class AccountScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(140),
        child: AppBar(
          flexibleSpace: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: <Color>[AppTheme.colorPrimary, AppTheme.colorSuccess],
              ),
            ),
            child: buildTitle(context),
          ),
        ),
      ),
      body: ListView(
        children: <Widget>[
          AppListTitle("account.myAccount"),
          AppListTile("account.myProfile", topDivider: true),
          AppListTile("account.changeEmailAddress"),
          AppListTile("account.changePassword"),
          AppListTile("account.myAddresses"),
          AppListTile("account.changePassword"),
          AppListTile("account.bankAccounts"),
          AppListTitle("account.settings"),
          AppListTile("account.changeLanguage",
              onTap: () => {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ChangeLanguageScreen(),
                      ),
                    )
                  },
              topDivider: true),
          Padding(
            padding: EdgeInsets.only(left: 60, right: 60, top: 60, bottom: 20),
            child: AppButton(
              FlutterI18n.translate(context, "account.logout"),
              () => {},
              size: AppButtonSize.small,
              type: AppButtonType.white,
            ),
          )
//            RaisedButton(
//              key: Key('changeLanguage'),
//              onPressed: () async {
//                GetIt.I<LanguageBloc>().add(SwitchLanguage(context));
//              },
//              child: Text(
//                FlutterI18n.translate(context, "button.label.switchLanguage"),
//              ),
//            ),
//            I18nText("button.label.language"),
        ],
      ),
    );
  }

  Widget buildTitle(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: Padding(
        padding: const EdgeInsets.only(top: 10),
        child: Column(
          children: <Widget>[
            FaDuotoneIcon(
              FontAwesomeIcons.duotoneUserCircle,
              secondaryColor: Colors.white,
              primaryColor: Colors.white.withOpacity(0.4),
              size: 60,
            ),
            SizedBox(
              height: 10,
            ),
            AppButton(
              FlutterI18n.translate(context, "account.loginSignup"),
              () => {},
              noPadding: true,
              size: AppButtonSize.small,
            )
          ],
        ),
      ),
    );
  }
}
