import 'package:auto_size_text/auto_size_text.dart';
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
import 'package:storeFlutter/models/auth/login-body.dart';
import 'package:storeFlutter/screens/account/forget-password.dart';
import 'package:storeFlutter/services/storage-service.dart';
import 'package:storeFlutter/util/app-theme.dart';
import 'package:storeFlutter/util/form-util.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormBuilderState> _fbKey = GlobalKey<FormBuilderState>();

  final StorageService _storageService = GetIt.I<StorageService>();

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
                            buildSavedLogin(context),
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
      listener: (context, state) {
        if (state is LoginInProgress) {
          AppLoadingDialog(context);
          hasDialog = true;
        } else {
          if (hasDialog) {
            Navigator.of(context).pop();
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
                    builder: (context) => ForgetPasswordScreen()),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget buildSavedLogin(BuildContext context) {
    // TODO display only if it's dev/test environment
    if (_storageService.savedLogins != null &&
        _storageService.savedLogins.length > 0) {
      return Padding(
        padding: EdgeInsets.symmetric(vertical: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Divider(
              thickness: 1,
//              color: AppTheme.colorDanger,
            ),
            Text(
              "Previously Saved Login",
              textAlign: TextAlign.center,
              style: TextStyle(
//                color: AppTheme.colorGray5,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 10),
            ...buildSavedLoginItem(),
            FlatButton(
              child: Text(
                "Clear All Saved Login",
                style: TextStyle(color: AppTheme.colorDanger),
              ),
              onPressed: () {
                _storageService.clearAllSavedLogin();
                setState(() {});
              },
            ),
            Divider(
              thickness: 1,
//              color: AppTheme.colorDanger,
            ),
          ],
        ),
      );
    } else {
      return SizedBox.shrink();
    }
  }

  List<Widget> buildSavedLoginItem() {
    return _storageService.savedLogins.map((e) {
      return Dismissible(
        direction: DismissDirection.endToStart,
        key: Key(e.username),
        background: Container(
          color: AppTheme.colorDanger,
        ),
        onDismissed: (direction) {
          _storageService.removeSavedLogin(e.username);
          setState(() {});
        },
        child: Card(
          color: AppTheme.colorSuccess,
          child: ListTile(
            title: AutoSizeText(
              e.username,
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
              minFontSize: 10,
              maxLines: 1,
            ),
            onTap: () {
              LoginBody body = LoginBody(e.username, e.password);
              GetIt.I<AuthBloc>().add(LoginEvent(body, context));
            },
          ),
        ),
      );
    }).toList();
  }
}
