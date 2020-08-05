import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:get_it/get_it.dart';
import 'package:storeFlutter/blocs/account/address-bloc.dart';
import 'package:storeFlutter/components/app-notification.dart';
import 'package:storeFlutter/components/form/drop-down-address-form.dart';
import 'package:storeFlutter/components/form/address-top-form.dart';
import 'package:storeFlutter/components/form/address-bottom-form.dart';
import 'package:storeFlutter/components/form/address-switch-form.dart';
import 'package:storeFlutter/components/form/address-button-form.dart';
import 'package:storeFlutter/services/storage-service.dart';
import 'package:storeFlutter/components/app-loading-dialog.dart';

class ManageAddressScreen extends StatefulWidget {
  final int id;

  ManageAddressScreen(this.id);
  @override
  _ManageAddressScreenState createState() => _ManageAddressScreenState();
}

class _ManageAddressScreenState extends State<ManageAddressScreen> {
  final GlobalKey<FormBuilderState> _fbAddress = GlobalKey<FormBuilderState>();
  final StorageService storageService = GetIt.I<StorageService>();

  bool hasDialog;
  bool isNew;

  @override
  void initState() {
    print("Initialize Manage Address Screen and State : ${widget.id}");

    // Default value
    isNew = widget.id == null || widget.id == 0;
    hasDialog = false;

    // Call service api
    if (!isNew) {
      print("[ManageAddressScreen] Existing case - ${widget.id}");
      GetIt.I<AddressBloc>().add(GetAddressByIDEvent(context, widget.id));
    } else {
      print("[ManageAddressScreen] New case");
      GetIt.I<AddressBloc>().add(GetCountryListEvent(context));
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: widget.id != null && widget.id != 0
            ? I18nText("account.editAddress")
            : I18nText("account.newAddress"),
      ),
      body: SafeArea(
        child: SingleChildScrollView(child: buildChild(context)),
      ),
    );
  }

  Widget buildChild(BuildContext context) {
    return BlocListener<AddressBloc, AddressState>(
      bloc: GetIt.I<AddressBloc>(),
      listener: (context, state) {
        print("[[ManageAddressScreen]] current state $state, $hasDialog");
        if (state is AddressInProgress) {
          AppLoadingDialog(context);
          if (!hasDialog) {
            hasDialog = true;
          }
        } else {
          if (hasDialog) {
            Navigator.of(context).pop();
            hasDialog = false;
          }
          if (state is ManageAddressFailed) {
            AppNotification(
                    FlutterI18n.translate(context, "error.pleaseTryAgain"))
                .show(context);
          } else if (state is SetAddressSuccess ||
              state is DeleteAddressSuccess) {
            print("Route here");
            Navigator.pop(context);
            // Navigator.popUntil(context, ModalRoute.withName('/'));
          }
        }
      },
      child: FormBuilder(
        key: _fbAddress,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Container(
              color: Colors.white,
              margin: const EdgeInsets.only(top: 10),
              padding: const EdgeInsets.all(10),
              child: Column(
                children: <Widget>[
                  AddressTopForm(),
                  SizedBox(height: 10),
                  DropDownAddressForm(),
                  SizedBox(height: 10),
                  AddressBottomForm(),
                  SizedBox(height: 15)
                ],
              ),
            ),
            AddressSwitchForm(),
            AddressButtonForm(_fbAddress, isNew),
            SizedBox(height: 10)
          ],
        ),
      ),
    );
  }
}
