import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:get_it/get_it.dart';
import 'package:storeFlutter/blocs/account/auth-bloc.dart';
import 'package:storeFlutter/components/app-button.dart';
import 'package:storeFlutter/util/app-theme.dart';

class CheckSession extends StatelessWidget {
  final Widget child;

  CheckSession({this.child});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      bloc: GetIt.I<AuthBloc>(),
      buildWhen: (previousState, state) {
        return (state is LoginSuccess || state is LogoutSuccess);
      },
      builder: (context, state) {
        if (state is LoginSuccess) {
          return child;
        } else {
          return getDefaultChild(context);
        }
      },
    );
  }

  Widget getDefaultChild(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(AppTheme.paddingStandard),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 60),
            child: Image(
              image: AssetImage('assets/images/eDagang.png'),
            ),
          ),
          Text(
            FlutterI18n.translate(context, "account.pleaseLoginToSeeMore"),
            textAlign: TextAlign.center,
//            style: TextStyle(fontSize: 17),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 40),
            child: AppButton(
              FlutterI18n.translate(context, "account.goToLogin"),
              () {
                Navigator.pushNamed(context, '/login');
              },
            ),
          )
        ],
      ),
    );
  }
}
