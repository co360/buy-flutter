import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:storeFlutter/components/app-button.dart';
import 'package:storeFlutter/components/app-notification.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:storeFlutter/services/storage-service.dart';
import 'package:storeFlutter/util/app-theme.dart';
import 'package:storeFlutter/blocs/account/change-email-bloc.dart';
import 'package:storeFlutter/util/form-util.dart';
import 'package:storeFlutter/models/identity/change-email-body.dart';

class ChangeEmailSecondLayer extends StatefulWidget {
  final String email;

  ChangeEmailSecondLayer(this.email);

  @override
  _ChangeEmailSecondLayerState createState() => _ChangeEmailSecondLayerState();
}

class _ChangeEmailSecondLayerState extends State<ChangeEmailSecondLayer> {
  final GlobalKey<FormBuilderState> _fbKey = GlobalKey<FormBuilderState>();
  final StorageService storageService = GetIt.I<StorageService>();

  @override
  Widget build(BuildContext context) {
    return BlocListener<ChangeEmailBloc, ChangeEmailState>(
      bloc: GetIt.I<ChangeEmailBloc>(),
      listener: (context, state) {
        print("current state $state");
        if (state is ConfirmCodeFailed) {
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
            RichText(
              text: TextSpan(
                text:
                    FlutterI18n.translate(context, "account.verificationCode"),
                style: TextStyle(color: Colors.black, fontSize: 15),
                children: <TextSpan>[
                  TextSpan(text: " "),
                  TextSpan(
                    text: widget.email,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 10),
            Align(
              alignment: Alignment.topLeft,
              child: FlatButton(
                textColor: AppTheme.colorLink,
                onPressed: () =>
                    {GetIt.I<ChangeEmailBloc>().add(InitChangeEmailEvent())},
                child: Text(
                    FlutterI18n.translate(context, "account.useDiffEmail"),
                    textAlign: TextAlign.left),
                shape:
                    CircleBorder(side: BorderSide(color: Colors.transparent)),
              ),
            ),
            SizedBox(height: 10),
            Text(FlutterI18n.translate(
                context, "account.checkVerificationCode")),
            SizedBox(height: 30),
            FormBuilder(
              key: _fbKey,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Flexible(
                    child: FormBuilderTextField(
                      attribute: 'c1',
                      maxLines: 1,
                      autocorrect: false,
                      decoration: InputDecoration(
                        counterText: "",
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: BorderSide(color: AppTheme.colorGray4)),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: BorderSide(color: AppTheme.colorGray4)),
                      ),
                      textAlign: TextAlign.center,
                      validators: [
                        FormUtil.required(context),
                      ],
                      keyboardType: TextInputType.number,
                      maxLength: 1,
                      maxLengthEnforced: true,
                    ),
                  ),
                  SizedBox(width: 5),
                  Flexible(
                    child: FormBuilderTextField(
                      attribute: 'c2',
                      maxLines: 1,
                      autocorrect: false,
                      decoration: InputDecoration(
                        counterText: "",
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: BorderSide(color: AppTheme.colorGray4)),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: BorderSide(color: AppTheme.colorGray4)),
                      ),
                      textAlign: TextAlign.center,
                      validators: [
                        FormUtil.required(context),
                      ],
                      keyboardType: TextInputType.number,
                      maxLength: 1,
                      maxLengthEnforced: true,
                    ),
                  ),
                  SizedBox(width: 5),
                  Flexible(
                    child: FormBuilderTextField(
                      attribute: 'c3',
                      maxLines: 1,
                      autocorrect: false,
                      decoration: InputDecoration(
                        counterText: "",
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: BorderSide(color: AppTheme.colorGray4)),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: BorderSide(color: AppTheme.colorGray4)),
                      ),
                      textAlign: TextAlign.center,
                      validators: [
                        FormUtil.required(context),
                      ],
                      keyboardType: TextInputType.number,
                      maxLength: 1,
                      maxLengthEnforced: true,
                    ),
                  ),
                  SizedBox(width: 5),
                  Flexible(
                    child: FormBuilderTextField(
                      attribute: 'c4',
                      maxLines: 1,
                      autocorrect: false,
                      decoration: InputDecoration(
                        counterText: "",
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: BorderSide(color: AppTheme.colorGray4)),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: BorderSide(color: AppTheme.colorGray4)),
                      ),
                      textAlign: TextAlign.center,
                      validators: [
                        FormUtil.required(context),
                      ],
                      keyboardType: TextInputType.number,
                      maxLength: 1,
                      maxLengthEnforced: true,
                    ),
                  ),
                  SizedBox(width: 5),
                  Flexible(
                    child: FormBuilderTextField(
                      attribute: 'c5',
                      maxLines: 1,
                      autocorrect: false,
                      decoration: InputDecoration(
                        counterText: "",
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: BorderSide(color: AppTheme.colorGray4)),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: BorderSide(color: AppTheme.colorGray4)),
                      ),
                      textAlign: TextAlign.center,
                      validators: [
                        FormUtil.required(context),
                      ],
                      keyboardType: TextInputType.number,
                      maxLength: 1,
                      maxLengthEnforced: true,
                    ),
                  ),
                  SizedBox(width: 5),
                  Flexible(
                    child: FormBuilderTextField(
                      attribute: 'c6',
                      maxLines: 1,
                      autocorrect: false,
                      decoration: InputDecoration(
                        counterText: "",
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: BorderSide(color: AppTheme.colorGray4)),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: BorderSide(color: AppTheme.colorGray4)),
                      ),
                      textAlign: TextAlign.center,
                      validators: [
                        FormUtil.required(context),
                      ],
                      keyboardType: TextInputType.number,
                      maxLength: 1,
                      maxLengthEnforced: true,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            Align(
              alignment: Alignment.center,
              child: SizedBox(
                width: 204,
                child: AppButton(
                  FlutterI18n.translate(context, "account.verifyNow"),
                  () {
                    print(_fbKey.currentState);
                    if (_fbKey.currentState.saveAndValidate()) {
                      print(_fbKey.currentState.value);
                      FocusScope.of(context).requestFocus(new FocusNode());
                      String code = _fbKey.currentState.value['c1'] +
                          _fbKey.currentState.value['c2'] +
                          _fbKey.currentState.value['c3'] +
                          _fbKey.currentState.value['c4'] +
                          _fbKey.currentState.value['c5'] +
                          _fbKey.currentState.value['c6'];
                      print(code);

                      sendConfirmationCode(context, widget.email, code);
                    } else {
                      print(_fbKey.currentState.value);
                      print('validation failed');
                    }
                  },
                  size: AppButtonSize.small,
                  noPadding: true,
                ),
              ),
            ),
            FlatButton(
              textColor: AppTheme.colorLink,
              onPressed: () => {resendConfirmationCode(context, widget.email)},
              child:
                  Text(FlutterI18n.translate(context, "account.didNotReceive"),
                      style: TextStyle(
                        fontSize: 14,
                      )),
              shape: CircleBorder(side: BorderSide(color: Colors.transparent)),
            ),
          ],
        ),
      ),
    );
  }

  resendConfirmationCode(BuildContext context, String newEmail) {
    ChangeEmailBody body =
        ChangeEmailBody(storageService.loginUser.email, newEmail, null);

    GetIt.I<ChangeEmailBloc>().add(SendChangeEmailEvent(body, context));
  }

  sendConfirmationCode(BuildContext context, String newEmail, String code) {
    ChangeEmailBody body =
        ChangeEmailBody(storageService.loginUser.email, newEmail, code);

    GetIt.I<ChangeEmailBloc>().add(SendConfirmCodeEvent(body, context));
  }
}
