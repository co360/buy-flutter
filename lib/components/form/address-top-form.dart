import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:storeFlutter/services/storage-service.dart';
import 'package:storeFlutter/blocs/account/address-bloc.dart';
import 'package:storeFlutter/util/app-theme.dart';
import 'package:storeFlutter/util/form-util.dart';

class AddressTopForm extends StatefulWidget {
  AddressTopForm({
    Key key,
  }) : super(key: key);

  @override
  _AddressTopFormState createState() => _AddressTopFormState();
}

class _AddressTopFormState extends State<AddressTopForm> {
  final StorageService storageService = GetIt.I<StorageService>();
  final _fullNameController = TextEditingController();
  final _phoneNoController = TextEditingController();

  @override
  void initState() {
    print("[AddressTopForm] Initialize");
    _fullNameController.text = storageService.loginUser.firstName == null
        ? ""
        : storageService.loginUser.firstName;
    _phoneNoController.text = storageService.loginUser.contactNo == null
        ? ""
        : storageService.loginUser.contactNo;
    super.initState();
  }

  @override
  void dispose() {
    _fullNameController.dispose();
    _phoneNoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AddressBloc, AddressState>(
      bloc: GetIt.I<AddressBloc>(),
      listener: (context, state) {
        print("[AddressTopForm] BlocListener");
        if (state is GetAddressByIDSuccess) {
          setState(() {
            _fullNameController.text = state.address.fullName;
            _phoneNoController.text = state.address.phoneNo;
          });
        }
      },
      child: buildChild(context),
    );
  }

  Widget buildChild(BuildContext context) {
    print("[AddressTopForm] buildChild");
    return Column(
      children: <Widget>[
        FormBuilderTextField(
          attribute: 'fullName',
          controller: _fullNameController,
          maxLines: 1,
          autocorrect: false,
          decoration: InputDecoration(
            enabledBorder: AppTheme.formInputEnabledBorder,
            focusedBorder: AppTheme.formInputFocusedBorder,
            labelText:
                FlutterI18n.translate(context, "account.address.fullName"),
          ),
          validators: [
            FormUtil.required(context),
          ],
          keyboardType: TextInputType.text,
        ),
        SizedBox(height: 10),
        FormBuilderTextField(
          attribute: 'phoneNo',
          controller: _phoneNoController,
          maxLines: 1,
          autocorrect: false,
          decoration: InputDecoration(
            enabledBorder: AppTheme.formInputEnabledBorder,
            focusedBorder: AppTheme.formInputFocusedBorder,
            labelText:
                FlutterI18n.translate(context, "account.address.phoneNumber"),
          ),
          validators: [
            FormUtil.required(context),
          ],
          keyboardType: TextInputType.phone,
        ),
      ],
    );
  }
}
