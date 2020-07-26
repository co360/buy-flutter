import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:storeFlutter/components/app-button.dart';
import 'package:storeFlutter/components/app-loading-dialog.dart';
import 'package:storeFlutter/components/app-notification.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:storeFlutter/services/storage-service.dart';
import 'package:storeFlutter/util/app-theme.dart';
import 'package:storeFlutter/blocs/account/change-email-bloc.dart';
import 'package:storeFlutter/util/form-util.dart';
import 'package:storeFlutter/models/identity/change-email-body.dart';

class ChangeEmailFirstLayer extends StatefulWidget {
  @override
  _ChangeEmailFirstLayerState createState() => _ChangeEmailFirstLayerState();
}

class _ChangeEmailFirstLayerState extends State<ChangeEmailFirstLayer> {
  final GlobalKey<FormBuilderState> _fbKey = GlobalKey<FormBuilderState>();
  final StorageService storageService = GetIt.I<StorageService>();

  @override
  Widget build(BuildContext context) {
    return BlocListener<ChangeEmailBloc, ChangeEmailState>(
      bloc: GetIt.I<ChangeEmailBloc>(),
      listener: (context, state) {
        print("current state $state");
        if (state is ChangeEmailFailed) {
          AppNotification(FlutterI18n.translate(context, "error.emailExisted"))
              .show(context);
          GetIt.I<ChangeEmailBloc>().add(InitChangeEmailEvent());
        } else if (state is ConfirmCodeSuccess) {
          Navigator.pop(context);
        }
      },
      child: Container(
        margin: const EdgeInsets.only(top: 20.0),
        padding: const EdgeInsets.all(20.0),
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Text(FlutterI18n.translate(context, "account.enterEmail")),
            SizedBox(height: 10),
            FormBuilder(
              key: _fbKey,
              child: Column(
                children: <Widget>[
                  FormBuilderTextField(
                    attribute: 'newEmail',
                    maxLines: 1,
                    autocorrect: false,
                    decoration: InputDecoration(
                      enabledBorder: AppTheme.formInputEnabledBorder,
                      focusedBorder: AppTheme.formInputFocusedBorder,
                      labelText:
                          FlutterI18n.translate(context, "account.newEmail"),
                    ),
                    validators: [
                      FormUtil.required(context),
                      FormUtil.email(context),
                    ],
                    keyboardType: TextInputType.emailAddress,
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            Row(children: <Widget>[
              SizedBox(
                width: 128,
                child: AppButton(
                  FlutterI18n.translate(context, "account.sendCode"),
                  () {
                    print(_fbKey.currentState);
                    if (_fbKey.currentState.saveAndValidate()) {
                      print(_fbKey.currentState.value);
                      FocusScope.of(context).requestFocus(new FocusNode());
                      ChangeEmailBody body =
                          ChangeEmailBody.fromJson(_fbKey.currentState.value);
                      body.email = storageService.loginUser.email;
                      print(body);

                      GetIt.I<ChangeEmailBloc>()
                          .add(SendChangeEmailEvent(body, context));
                    } else {
                      print(_fbKey.currentState.value);
                      print('validation failed');
                    }
                  },
                  size: AppButtonSize.small,
                  noPadding: true,
                ),
              ),
            ])
          ],
        ),
      ),
    );
  }
}
