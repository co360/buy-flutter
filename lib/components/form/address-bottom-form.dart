import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:storeFlutter/services/storage-service.dart';
import 'package:storeFlutter/blocs/account/address-bloc.dart';
import 'package:storeFlutter/util/app-theme.dart';
import 'package:storeFlutter/util/form-util.dart';

class AddressBottomForm extends StatefulWidget {
  AddressBottomForm({
    Key key,
  }) : super(key: key);

  @override
  _AddressBottomFormState createState() => _AddressBottomFormState();
}

class _AddressBottomFormState extends State<AddressBottomForm> {
  final StorageService storageService = GetIt.I<StorageService>();
  final _postcodeController = TextEditingController();
  final _addressController = TextEditingController();

  @override
  void initState() {
    print("[AddressBottomForm] Initialize");
    super.initState();
  }

  @override
  void dispose() {
    _postcodeController.dispose();
    _addressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AddressBloc, AddressState>(
      bloc: GetIt.I<AddressBloc>(),
      listener: (context, state) {
        print("[AddressBottomForm] BlocListener");
        if (state is GetAddressByIDSuccess) {
          setState(() {
            _postcodeController.text = state.address.postcode;
            _addressController.text = state.address.address;
          });
        }
      },
      child: buildChild(context),
    );
  }

  Widget buildChild(BuildContext context) {
    print("[AddressBottomForm] buildChild");
    return Column(
      children: <Widget>[
        FormBuilderTextField(
          attribute: 'postcode',
          controller: _postcodeController,
          maxLines: 1,
          autocorrect: false,
          decoration: InputDecoration(
            enabledBorder: AppTheme.formInputEnabledBorder,
            focusedBorder: AppTheme.formInputFocusedBorder,
            labelText:
                FlutterI18n.translate(context, "account.address.postcode"),
          ),
          validators: [
            FormUtil.required(context),
          ],
          keyboardType: TextInputType.number,
        ),
        SizedBox(height: 10),
        FormBuilderTextField(
          attribute: 'address',
          controller: _addressController,
          maxLines: 1,
          autocorrect: false,
          decoration: InputDecoration(
            enabledBorder: AppTheme.formInputEnabledBorder,
            focusedBorder: AppTheme.formInputFocusedBorder,
            labelText:
                FlutterI18n.translate(context, "account.address.address"),
          ),
          validators: [
            FormUtil.required(context),
          ],
          keyboardType: TextInputType.text,
        ),
      ],
    );
  }
}
