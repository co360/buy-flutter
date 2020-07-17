import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get_it/get_it.dart';
import 'package:storeFlutter/blocs/account/auth-bloc.dart';
import 'package:storeFlutter/components/app-button.dart';
import 'package:storeFlutter/components/app-list-tile.dart';
import 'package:storeFlutter/components/app-list-title.dart';
import 'package:storeFlutter/screens/account/change-language.dart';
import 'package:storeFlutter/services/storage-service.dart';
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
            child: BlocBuilder<AuthBloc, AuthState>(
              bloc: GetIt.I<AuthBloc>(),
              buildWhen: (previousState, state) {
                return (state is LoginSuccess || state is LogoutSuccess);
              },
              builder: (context, state) {
                if (state is LoginSuccess) {
                  return buildSessionTitle(context);
                } else {
                  return buildSessionlessTitle(context);
                }
              },
            ),
          ),
        ),
      ),
      body: BlocBuilder<AuthBloc, AuthState>(
        bloc: GetIt.I<AuthBloc>(),
        buildWhen: (previousState, state) {
          return (state is LoginSuccess || state is LogoutSuccess);
        },
        builder: (context, state) {
          if (state is LoginSuccess) {
            return buildSessionContent(context);
          } else {
            return buildSessionlessContent(context);
          }
        },
      ),
    );
  }

  Widget buildSessionContent(BuildContext context) {
    return ListView(
      children: <Widget>[
        AppListTitle("account.myAccount"),
        AppListTile("account.myProfile", topDivider: true),
        AppListTile("account.changeEmailAddress"),
        AppListTile("account.changePassword"),
        AppListTile("account.myAddresses"),
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
            () => {GetIt.I<AuthBloc>().add(LogoutEvent())},
            size: AppButtonSize.small,
            type: AppButtonType.white,
          ),
        )
      ],
    );
  }

  Widget buildSessionlessContent(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
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
            () => {GetIt.I<AuthBloc>().add(LogoutEvent())},
            size: AppButtonSize.small,
            type: AppButtonType.white,
          ),
        )
      ],
    );
  }

  Widget buildSessionlessTitle(BuildContext context) {
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
              () => {
                Navigator.pushNamed(context, '/login'),
              },
              noPadding: true,
              size: AppButtonSize.small,
            )
          ],
        ),
      ),
    );
  }

  Widget buildSessionTitle(BuildContext context) {
    StorageService storageService = GetIt.I<StorageService>();
    return SafeArea(
      bottom: false,
      child: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20, top: 10),
        child: Column(
//          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            FaDuotoneIcon(
              FontAwesomeIcons.duotoneUserCircle,
              secondaryColor: Colors.white,
              primaryColor: Colors.white.withOpacity(0.4),
              size: 60,
            ),
            SizedBox(
              height: 20,
            ),
            Expanded(
              child: AutoSizeText(
                storageService.loginUser.name,
                minFontSize: 14,
                style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                    fontSize: 19),
              ),
            )
          ],
        ),
      ),
    );
  }
}
