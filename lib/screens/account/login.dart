import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:get_it/get_it.dart';
import 'package:storeFlutter/blocs/account/auth-bloc.dart';
import 'package:storeFlutter/components/app-button.dart';
import 'package:storeFlutter/components/app-card.dart';
import 'package:storeFlutter/components/app-loading-dialog.dart';
import 'package:storeFlutter/components/app-notification.dart';
import 'package:storeFlutter/screens/account/forget-password.dart';
import 'package:storeFlutter/models/auth/login-body.dart';
import 'package:storeFlutter/screens/account/signup.dart';
import 'package:storeFlutter/util/app-theme.dart';
import 'package:storeFlutter/util/form-util.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormBuilderState> _fbKey = GlobalKey<FormBuilderState>();

//  AppLoadingDialog dialog;
  bool hasDialog = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: I18nText("account.login"),
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
                              buildForm(context),
                              padding: EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 10),
                            ),
                            FlatButton(
                              splashColor: Colors.transparent,
                              highlightColor: Colors.transparent,
                              child: Text(
                                FlutterI18n.translate(
                                    context, "account.noAccountYet"),
                                style: TextStyle(
                                  color: AppTheme.colorLink,
                                ),
                              ),
                              onPressed: () => {
                                Navigator.popAndPushNamed(context, '/signup'),
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

  Widget buildForm(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      bloc: GetIt.I<AuthBloc>(),
//      condition: (prevState, currentState) {
//        if (prevState is LoginInProgress) {
//          if (hasDialog) {
//            Navigator.pop(context);
//          }
//        }
//        return true;
//      },
      listener: (context, state) {
        print("current state $state , hasDialog $hasDialog");
        if (state is LoginInProgress) {
          print("we wang wang");
//          dialog = AppLoadingDialog(context);
          AppLoadingDialog(context);
          hasDialog = true;
        } else {
          if (hasDialog) {
            print("try to pop");
            Navigator.of(context).pop();
//            dialog.pop();
//            dialog = null;
            hasDialog = false;
          }

          if (state is LoginSuccess) {
            // TODO should navigate back to the home page
            Navigator.pop(context);
          } else if (state is LoginFailure) {
            AppNotification(
                    FlutterI18n.translate(context, "error.${state.error}"))
                .show(context);
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
                  attribute: 'username',
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
                FormBuilderTextField(
                  attribute: 'password',
                  obscureText: true,
                  maxLines: 1,
                  decoration: InputDecoration(
                    enabledBorder: AppTheme.formInputEnabledBorder,
                    focusedBorder: AppTheme.formInputFocusedBorder,
                    labelText:
                        FlutterI18n.translate(context, "account.password"),
                  ),
                  validators: [
                    FormUtil.required(context),
                  ],
                ),
                SizedBox(height: 15),
              ],
            ),
          ),
          AppButton(
            FlutterI18n.translate(context, "account.login"),
            () {
              if (_fbKey.currentState.saveAndValidate()) {
                print(_fbKey.currentState.value);
                FocusScope.of(context).requestFocus(new FocusNode());
                LoginBody body = LoginBody.fromJson(_fbKey.currentState.value);
                print(body);

                GetIt.I<AuthBloc>().add(LoginEvent(body, context));

//              pop3();
              } else {
                print(_fbKey.currentState.value);
                print('validation failed');
//              pop3();
//                AppLoadingDialog(context);
              }
            },
            size: AppButtonSize.small,
            noPadding: true,
          ),
          FlatButton(
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            child: Text(
              FlutterI18n.translate(context, "account.forgetPassword"),
              style: TextStyle(color: AppTheme.colorLink),
            ),
            onPressed: () {
                Navigator.push(
                  context,
                  CupertinoPageRoute(
                    builder: (context) => ForgetPasswordScreen()
                    ),
                  );
                },
          ),
        ],
      ),
    );
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

  pop3() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return WillPopScope(
          onWillPop: () {},
          child: new AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
            content: Row(
              children: <Widget>[
                CircularProgressIndicator(
                  strokeWidth: 2,
                ),
                SizedBox(
                  width: 20,
                ),
                Expanded(
                  child: Text(
                    "Please wait ",
                    maxLines: 3,
                  ),
                )
              ],
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
      },
    );
  }

  pop2() {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return Text("123");
        });
  }
}
