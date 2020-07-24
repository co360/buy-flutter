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
import 'package:storeFlutter/blocs/account/profile-bloc.dart';
import 'package:storeFlutter/util/form-util.dart';
import 'package:storeFlutter/models/identity/account.dart';

class EditProfileScreen extends StatefulWidget {
  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final GlobalKey<FormBuilderState> _fbKey = GlobalKey<FormBuilderState>();
  final StorageService storageService = GetIt.I<StorageService>();

  bool hasDialog = false;

  @override
  void initState() {
    print("Initialize EditProfileScreen Screen and State");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: I18nText("account.editProfile"),
      ),
      body: SafeArea(
        child: GestureDetector(
          onTap: () => {FocusScope.of(context).requestFocus(new FocusNode())},
          behavior: HitTestBehavior.translucent,
          child: LayoutBuilder(
            builder:
                (BuildContext context, BoxConstraints viewportConstraints) {
              return SizedBox(
                height: 247,
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
    return BlocListener<ProfileBloc, ProfileState>(
      bloc: GetIt.I<ProfileBloc>(),
      listener: (context, state) {
        print("current state $state");
        if (state is ProfileInProgress) {
          AppLoadingDialog(context);
          hasDialog = true;
        } else {
          if (hasDialog) {
            Navigator.of(context).pop();
            hasDialog = false;
          }
          if (state is ProfileFailed) {
            AppNotification(FlutterI18n.translate(context, "error.notExist"))
                .show(context);
            GetIt.I<ProfileBloc>().add(InitProfileEvent());
          } else if (state is ProfileSuccess) {
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
                  attribute: 'name',
                  initialValue: storageService.loginUser.name,
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
                SizedBox(height: 10),
                FormBuilderTextField(
                  attribute: 'contactNo',
                  initialValue: storageService.loginUser.contactNo,
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
                SizedBox(height: 15),
              ],
            ),
          ),
          SizedBox(height: 10),
          Row(children: <Widget>[
            SizedBox(
              width: 93,
              child: AppButton(
                FlutterI18n.translate(context, "account.save"),
                () {
                  if (_fbKey.currentState.saveAndValidate()) {
                    print(_fbKey.currentState.value);
                    FocusScope.of(context).requestFocus(new FocusNode());
                    Account temp = Account.fromJson(_fbKey.currentState.value);
                    Account body = storageService.loginUser;
                    body.name = temp.name;
                    body.contactNo = temp.contactNo;
                    print(body);

                    GetIt.I<ProfileBloc>().add(
                        SaveProfileEvent(storageService.loginUser.id, body));
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
