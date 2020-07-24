import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get_it/get_it.dart';
import 'package:storeFlutter/blocs/account/auth-bloc.dart';
import 'package:storeFlutter/blocs/account/signup-bloc.dart';
import 'package:storeFlutter/components/app-button.dart';
import 'package:storeFlutter/components/app-card.dart';
import 'package:storeFlutter/components/app-loading-dialog.dart';
import 'package:storeFlutter/components/app-notification.dart';
import 'package:storeFlutter/models/auth/login-body.dart';
import 'package:storeFlutter/models/identity/signup-body.dart';
import 'package:storeFlutter/services/account-service.dart';
import 'package:storeFlutter/util/app-theme.dart';
import 'package:storeFlutter/util/form-util.dart';

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final GlobalKey<FormBuilderState> _fbKey = GlobalKey<FormBuilderState>();

//  AppLoadingDialog dialog;
  bool hasDialog = false;

  @override
  void initState() {
    GetIt.I<SignUpBloc>().add(InitSignUpEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: I18nText("account.signup"),
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
                              BlocBuilder<SignUpBloc, SignUpState>(
                                  bloc: GetIt.I<SignUpBloc>(),
                                  builder: (context, state) {
                                    if (state is SignUpSuccess) {
                                      return generateRegisterConfirmationForm(
                                          context);
                                    } else {
                                      return buildForm(context);
                                    }
                                  }),
                              padding: EdgeInsets.fromLTRB(20, 0, 20, 10),
                            ),
                            FlatButton(
                              splashColor: Colors.transparent,
                              highlightColor: Colors.transparent,
                              child: Text(
                                FlutterI18n.translate(
                                    context, "account.goToLogin"),
                                style: TextStyle(
                                  color: AppTheme.colorLink,
                                ),
                              ),
                              onPressed: () => {
                                Navigator.popAndPushNamed(context, '/login'),
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
    return BlocListener<SignUpBloc, SignUpState>(
      bloc: GetIt.I<SignUpBloc>(),
//      condition: (prevState, currentState) {
//        if (prevState is SignUpInProgress) {
//          if (hasDialog) {
//            Navigator.pop(context);
//          }
//        }
//        return true;
//      },
      listener: (context, state) {

        if (state is SignUpInProgress) {
//          dialog = AppLoadingDialog(context);
//          AppLoadingDialog(context);
          hasDialog = true;
        } else {
          if (hasDialog) {
//            Navigator.of(context).pop();
            hasDialog = false;
          }
          if (state is SignUpFailure) {
            AppNotification(
                    FlutterI18n.translate(context, "error.emailExisted"))
                .show(context);
            GetIt.I<SignUpBloc>().add(InitSignUpEvent());
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
                  attribute: 'name',
                  maxLines: 1,
                  autocorrect: false,
                  decoration: InputDecoration(
                    enabledBorder: AppTheme.formInputEnabledBorder,
                    focusedBorder: AppTheme.formInputFocusedBorder,
                    labelText: FlutterI18n.translate(context, "account.name"),
                  ),
                  validators: [
                    FormUtil.required(context),
                  ],
                  keyboardType: TextInputType.text,
                ),
                FormBuilderTextField(
                  attribute: 'contact',
                  maxLines: 1,
                  autocorrect: false,
                  decoration: InputDecoration(
                    enabledBorder: AppTheme.formInputEnabledBorder,
                    focusedBorder: AppTheme.formInputFocusedBorder,
                    labelText:
                        FlutterI18n.translate(context, "account.mobileContact"),
                  ),
                  validators: [
                    FormUtil.required(context),
                  ],
                  keyboardType: TextInputType.phone,
                ),
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
                    FormUtil.pattern(
                        context,
                        "(?=.*[a-z])(?=.*[A-Z])(?=.*[0-9])(?=.*[\$@\$!%*?&]).{8,}",
                        "error.passwordPattern")
                  ],
                ),
                FormBuilderTextField(
                  attribute: 'confirmPassword',
                  obscureText: true,
                  maxLines: 1,
                  decoration: InputDecoration(
                    enabledBorder: AppTheme.formInputEnabledBorder,
                    focusedBorder: AppTheme.formInputFocusedBorder,
                    labelText: FlutterI18n.translate(
                        context, "account.confirmPassword"),
                  ),
                  validators: [
                    FormUtil.required(context),
                    FormUtil.match(context, _fbKey.currentState, 'password', 'error.passwordNotMatch')
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 15.0),
                  child: Card(
                    color: AppTheme.colorBg2,
                    shadowColor: Color(0xFF2E95C6).withOpacity(0.3),
                    elevation: 3,
//        margin: EdgeInsets.zero,
                    shape: RoundedRectangleBorder(
                      side: BorderSide(
                        color: Colors.transparent,
                      ),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
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
                ),
              ],
            ),
          ),
          AppButton(
            FlutterI18n.translate(context, "account.signupSpace"),
            () {
              if (_fbKey.currentState.saveAndValidate()) {
                print(_fbKey.currentState.value);
                FocusScope.of(context).requestFocus(new FocusNode());
                RegisterAccount acct =
                    RegisterAccount.fromJson(_fbKey.currentState.value);
                acct.accountType = 'INDIVIDUAL';
                RegisterCompany cmpy = RegisterCompany(acct.name);
                SignUpBody body = SignUpBody(acct, cmpy);
                print(body);

                GetIt.I<SignUpBloc>().add(RegisterEvent(body, context));

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

  Widget generateRegisterConfirmationForm(BuildContext context) {
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
            margin: const EdgeInsets.only(top: 30.0, bottom: 20.0),
            child: Column(
              children: <Widget>[
                Text(
                  FlutterI18n.translate(context, "account.registration.sentRegistrationEmail"),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16.0,
                    color: Colors.black,
                  ),
                ),
                Text(
                  FlutterI18n.translate(context, "account.registration.checkRegistrationEmail"),
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
}
