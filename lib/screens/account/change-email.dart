import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:storeFlutter/services/storage-service.dart';
import 'package:storeFlutter/blocs/account/change-email-bloc.dart';
import 'package:storeFlutter/components/app-list-tile-two-cols.dart';

import 'package:storeFlutter/components/account/change-email-first-layer.dart';
import 'package:storeFlutter/components/account/change-email-second-layer.dart';

class ChangeEmailScreen extends StatefulWidget {
  @override
  _ChangeEmailScreenState createState() => _ChangeEmailScreenState();
}

class _ChangeEmailScreenState extends State<ChangeEmailScreen> {
  final StorageService storageService = GetIt.I<StorageService>();

  @override
  void initState() {
    print("Initialize ChangeEmailScreen Screen and State");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ChangeEmailBloc>(
      create: (context) => ChangeEmailBloc(),
      child: Builder(builder: (context) {
        return Scaffold(
          appBar: AppBar(
            title: I18nText("account.changeEmailAddress"),
          ),
          body: SafeArea(
            child: GestureDetector(
              onTap: () =>
                  {FocusScope.of(context).requestFocus(new FocusNode())},
              behavior: HitTestBehavior.translucent,
              child: LayoutBuilder(
                builder:
                    (BuildContext context, BoxConstraints viewportConstraints) {
                  return SingleChildScrollView(
                    child: Column(children: <Widget>[
                      SizedBox(
                        height: 120,
                        child: Container(
                          margin: const EdgeInsets.only(top: 20.0),
                          padding: const EdgeInsets.all(10.0),
                          color: Colors.white,
                          child: buildForm(context),
                        ),
                      ),
                      BlocBuilder<ChangeEmailBloc, ChangeEmailState>(
                          builder: (context, state) {
                        print("current state $state");
                        switch (state.runtimeType) {
                          case ChangeEmailSuccess:
                          case ConfirmCodeSuccess:
                            {
                              print(state.props);
                              return ChangeEmailSecondLayer(state.props[0]);
                            }
                          default:
                            return ChangeEmailFirstLayer();
                        }
                      }),
                    ]),
                  );
                },
              ),
            ),
          ),
        );
      }),
    );
  }

  Widget buildForm(BuildContext context) {
    return ListView(children: <Widget>[
      AppListTileTwoCols(FlutterI18n.translate(context, "account.currentEmail"),
          storageService.loginUser.email,
          bottomDivider: false),
    ]);
  }
}
