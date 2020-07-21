import 'package:flutter/services.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get_it/get_it.dart';
import 'package:storeFlutter/blocs/account/account-bloc.dart';
import 'package:storeFlutter/blocs/account/forget-password-bloc.dart';
import 'package:storeFlutter/components/app-button.dart';
import 'package:storeFlutter/components/app-card.dart';
import 'package:storeFlutter/components/app-loading-dialog.dart';
import 'package:storeFlutter/components/app-notification.dart';
import 'package:storeFlutter/models/identity/forget-password-body.dart';
import 'package:storeFlutter/util/app-theme.dart';
import 'package:storeFlutter/util/form-util.dart';

class ForgetPasswordScreen extends StatefulWidget {
  @override
  _ForgetPasswordScreenState createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  final GlobalKey<FormBuilderState> _fbKey = GlobalKey<FormBuilderState>();

//  AppLoadingDialog dialog;
  bool hasDialog = false;

  @override
  void initState() {
    print("Initialize ForgotPassword Screen and State");
    SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);
    GetIt.I<ForgetPasswordBloc>().add(InitForgetPasswordEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: I18nText("account.forgetPassword"),
      ),
      body: SafeArea(
        child: GestureDetector(
          onTap: () => {FocusScope.of(context).requestFocus(new FocusNode())},
          behavior: HitTestBehavior.translucent,
          child: LayoutBuilder(
            builder:
                (BuildContext context, BoxConstraints viewportConstraints) {
              return SingleChildScrollView(
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    minHeight: viewportConstraints.maxHeight,
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(AppTheme.paddingStandard),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 30.0, horizontal: 60),
                              child: Image(
                                image: AssetImage('assets/images/eDagang.png'),
                              ),
                            ),
                            AppCard(
                              BlocBuilder<ForgetPasswordBloc, ForgetPasswordState>(
                                bloc: GetIt.I<ForgetPasswordBloc>(),
                                builder: (context, state) {
                                  print("current state $state");
                                  if (state is ForgetPasswordSuccess) {
                                    return generateConfirmationForm(context);
                                  } else {
                                    return buildForm(context);
                                  }
                                }
                              ),                              
                              padding: EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 10),
                            ),
                            FlatButton(
                              splashColor: Colors.transparent,
                              highlightColor: Colors.transparent,
                              child: Text(
                                FlutterI18n.translate(
                                    context, "account.backToLogin"),
                                style: TextStyle(
                                  color: AppTheme.colorLink,
                                ),
                              ),
                              onPressed: () {
                                Navigator.pop(context);
                              },
                            ),
                          ],
                        ),
                        Column(
                          children: <Widget>[
                            I18nText("account.inCollaborationWith"),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 20.0, horizontal: 60),
                              child: Image(
                                image: AssetImage(
                                    'assets/images/smart-tradzt.png'),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget generateConfirmationForm(BuildContext context) {

    return Container(
      padding: const EdgeInsets.all(8.0),
      alignment: Alignment.center,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Center(            
            child: FaDuotoneIcon(
              FontAwesomeIcons.duotoneCheck,
              secondaryColor: Color(int.parse("0xFFF37318")),
              primaryColor: Color(int.parse("0xFFF37318")),
              size: 60,          
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 50.0, bottom: 20.0),
            child: Column(
              children: <Widget>[
                Text(
                  FlutterI18n.translate(
                      context, "account.sentEmail"),
                  textAlign: TextAlign.center,            
                  style: TextStyle(
                    fontSize: 16.0, 
                    color: Colors.black,
                  ),
                ),
                Text(
                  FlutterI18n.translate(
                      context, "account.checkEmail"),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16.0, 
                    color: Colors.black,
                  ),
                ),              
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildForm(BuildContext context) {
    return BlocListener<ForgetPasswordBloc, ForgetPasswordState>(
      bloc: GetIt.I<ForgetPasswordBloc>(),
      listener: (context, state) {
        print("current state $state , hasDialog $hasDialog");
        if (state is ForgetPasswordFailed) {          
          AppNotification(
                  FlutterI18n.translate(context, "error.notExist"))
              .show(context);
          GetIt.I<ForgetPasswordBloc>().add(InitForgetPasswordEvent());
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
                  attribute: 'email',
                  maxLines: 1,
                  autocorrect: false,
                  decoration: InputDecoration(
                    enabledBorder: AppTheme.formInputEnabledBorder,
                    focusedBorder: AppTheme.formInputFocusedBorder,
                    labelText: FlutterI18n.translate(context, "account.email"),
                  ),
                  validators: [
                    FormUtil.required(context),
                    FormUtil.email(context),
                  ],
                  keyboardType: TextInputType.emailAddress,
                ),
                SizedBox(height: 15),
              ],
            ),
          ),
          AppButton(
            FlutterI18n.translate(context, "account.resetPassword"),
            () {
              if (_fbKey.currentState.saveAndValidate()) {
                print(_fbKey.currentState.value);
                FocusScope.of(context).requestFocus(new FocusNode());
                ForgetPasswordBody body = ForgetPasswordBody.fromJson(_fbKey.currentState.value);
                print(body);

                GetIt.I<ForgetPasswordBloc>().add(LoadForgetPasswordEvent(body, context));
              } else {
                print(_fbKey.currentState.value);
                print('validation failed');
              }
            },
            size: AppButtonSize.small,
            noPadding: true,
          ),
        ],
      ),
    );
  }
}
