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
import 'package:storeFlutter/blocs/account/change-password-bloc.dart';
import 'package:storeFlutter/util/form-util.dart';
import 'package:storeFlutter/models/identity/change-password-body.dart';

class ChangePasswordScreen extends StatefulWidget {
  @override
  _ChangePasswordScreenState createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final GlobalKey<FormBuilderState> _fbKey = GlobalKey<FormBuilderState>();
  final StorageService storageService = GetIt.I<StorageService>();

  bool hasDialog = false;

  @override
  void initState() {
    print("Initialize ChangePasswordScreen Screen and State");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: I18nText("account.changePassword"),
      ),
      body: SafeArea(
        child: GestureDetector(
          onTap: () => {FocusScope.of(context).requestFocus(new FocusNode())},
          behavior: HitTestBehavior.translucent,
          child: LayoutBuilder(
            builder:
                (BuildContext context, BoxConstraints viewportConstraints) {
              return SizedBox(
                height: 550,
                child: Container(
                  margin: const EdgeInsets.only(top: 20.0),
                  padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                  color: Colors.white,
                  child: buildForm(context),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget buildForm(BuildContext context) {
    return BlocListener<ChangePasswordBloc, ChangePasswordState>(
      bloc: GetIt.I<ChangePasswordBloc>(),
      listener: (context, state) {
        print("current state $state");
        if (state is ChangePasswordInProgress) {
          AppLoadingDialog(context);
          hasDialog = true;
        } else {
          if (hasDialog) {
            Navigator.of(context).pop();
            hasDialog = false;
          }
          if (state is ChangePasswordFailed) {
            AppNotification(
                    FlutterI18n.translate(context, "error.oldPasswordInvalid"))
                .show(context);
            GetIt.I<ChangePasswordBloc>().add(InitChangePasswordEvent());
          } else if (state is ChangePasswordSuccess) {
            Navigator.pop(context);
          }
        }
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          FormBuilder(
            key: _fbKey,
            child: Column(
              children: <Widget>[
                FormBuilderTextField(
                  attribute: 'oldPassword',
                  maxLines: 1,
                  autocorrect: false,
                  obscureText: true,
                  decoration: InputDecoration(
                    enabledBorder: AppTheme.formInputEnabledBorder,
                    focusedBorder: AppTheme.formInputFocusedBorder,
                    labelText:
                        FlutterI18n.translate(context, "account.oldPassword"),
                  ),
                  validators: [
                    FormUtil.required(context),
                  ],
                  keyboardType: TextInputType.text,
                ),
                SizedBox(height: 10),
                FormBuilderTextField(
                  attribute: 'newPassword',
                  maxLines: 1,
                  autocorrect: false,
                  obscureText: true,
                  decoration: InputDecoration(
                    enabledBorder: AppTheme.formInputEnabledBorder,
                    focusedBorder: AppTheme.formInputFocusedBorder,
                    labelText:
                        FlutterI18n.translate(context, "account.newPassword"),
                  ),
                  validators: [
                    FormUtil.required(context),
                    FormUtil.pattern(
                        context,
                        "(?=.*[a-z])(?=.*[A-Z])(?=.*[0-9])(?=.*[\$@\$!%*?&]).{8,}",
                        "error.passwordPattern"),
                    (val) {
                      if (_fbKey.currentState.fields['oldPassword'].currentState
                              .value ==
                          val)
                        return FlutterI18n.translate(
                            context, "error.passwordSame");
                    },
                  ],
                  keyboardType: TextInputType.text,
                ),
                SizedBox(height: 10),
                FormBuilderTextField(
                  attribute: 'newPasswordConf',
                  maxLines: 1,
                  autocorrect: false,
                  obscureText: true,
                  decoration: InputDecoration(
                    enabledBorder: AppTheme.formInputEnabledBorder,
                    focusedBorder: AppTheme.formInputFocusedBorder,
                    labelText: FlutterI18n.translate(
                        context, "account.confirmPassword"),
                  ),
                  validators: [
                    FormUtil.required(context),
                    FormUtil.match(context, _fbKey.currentState, 'newPassword',
                        'error.passwordNotMatch')
                  ],
                  keyboardType: TextInputType.text,
                ),
                SizedBox(height: 15),
              ],
            ),
          ),
          SizedBox(height: 10),
          Container(
            color: AppTheme.colorBg2,
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text(
                      FlutterI18n.translate(
                          context, "account.passwordSuggestion.title"),
                      style: TextStyle(
                          color: AppTheme.colorLink,
                          fontWeight: FontWeight.w500)),
                  SizedBox(
                    height: 10,
                  ),
                  suggestionText(FlutterI18n.translate(
                      context, "account.passwordSuggestion.minimum")),
                  suggestionText(FlutterI18n.translate(
                      context, "account.passwordSuggestion.upper")),
                  suggestionText(FlutterI18n.translate(
                      context, "account.passwordSuggestion.lower")),
                  suggestionText(FlutterI18n.translate(
                      context, "account.passwordSuggestion.numeric")),
                  suggestionText(FlutterI18n.translate(
                      context, "account.passwordSuggestion.special")),
                ],
              ),
            ),
          ),
          SizedBox(height: 10),
          Row(children: <Widget>[
            SizedBox(
              width: 204,
              child: AppButton(
                FlutterI18n.translate(context, "account.changePassword"),
                () {
                  if (_fbKey.currentState.saveAndValidate()) {
                    print(_fbKey.currentState.value);
                    FocusScope.of(context).requestFocus(new FocusNode());
                    ChangePasswordBody body =
                        ChangePasswordBody.fromJson(_fbKey.currentState.value);
                    body.userId = storageService.loginUser.userName;
                    print(body);

                    GetIt.I<ChangePasswordBloc>().add(SaveChangePasswordEvent(
                        storageService.loginUser.userName, body, context));
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
    );
  }

  Text suggestionText(String text) {
    return Text(text, style: TextStyle(color: AppTheme.colorGray6));
  }

  pop() {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return WillPopScope(
            onWillPop: () {},
            child: new AlertDialog(
              content: ConstrainedBox(
                constraints: BoxConstraints(maxHeight: 200),
                child: Column(
                  children: <Widget>[
                    CircularProgressIndicator(),
                    Text("Please wait...")
                  ],
                ),
              ),
              actions: <Widget>[
                new FlatButton(
                  onPressed: () {
                    //Function called
                  },
                  child: new Text('Ok Done!'),
                ),
                new FlatButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: new Text('Go Back'),
                ),
              ],
            ),
          );
        });
  }
}
