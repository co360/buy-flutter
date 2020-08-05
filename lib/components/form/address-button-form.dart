import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:get_it/get_it.dart';
import 'package:storeFlutter/blocs/account/address-bloc.dart';
import 'package:storeFlutter/components/app-button.dart';
import 'package:storeFlutter/components/app-confirmation-dialog.dart';
import 'package:storeFlutter/models/identity/location.dart';
import 'package:storeFlutter/services/storage-service.dart';
import 'package:storeFlutter/util/app-theme.dart';

class AddressButtonForm extends StatefulWidget {
  final GlobalKey<FormBuilderState> _fbAddressLocal;
  final bool isNew;

  AddressButtonForm(
    this._fbAddressLocal,
    this.isNew, {
    Key key,
  }) : super(key: key);

  @override
  _AddressButtonFormState createState() => _AddressButtonFormState();
}

class _AddressButtonFormState extends State<AddressButtonForm> {
  final StorageService storageService = GetIt.I<StorageService>();
  Location location;
  bool isHome = true;

  @override
  void initState() {
    print("Initialize AddressButtonForm and State");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AddressBloc, AddressState>(
      bloc: GetIt.I<AddressBloc>(),
      listener: (context, state) {
        print("[AddressBottomForm] BlocListener");
        if (state is GetAddressByIDSuccess) {
          setState(() {
            location = state.address;
            isHome = state.address.locationType == "HOME" ? true : false;
          });
        } else if (state is SetAddressHomeSuccess) {
          setState(() {
            isHome = state.isHome;
          });
        }
      },
      child: buildChild(context),
    );
  }

  Widget buildChild(BuildContext context) {
    return Column(
      children: <Widget>[
        widget.isNew
            ? Container()
            : Container(
                color: Colors.white,
                margin: const EdgeInsets.only(top: 10, bottom: 10),
                // padding: const EdgeInsets.all(10),
                alignment: Alignment.centerLeft,
                child: FlatButton(
                  textColor: AppTheme.colorDanger,
                  onPressed: () {
                    if (widget._fbAddressLocal.currentState.saveAndValidate()) {
                      print(widget._fbAddressLocal.currentState.value);
                      FocusScope.of(context).requestFocus(new FocusNode());

                      print("Delete Op: ${location.id}");
                      AppConfirmationDialog(context,
                          title: FlutterI18n.translate(
                              context, "general.deleteTitle"),
                          content: FlutterI18n.translate(
                              context, "general.deleteContent"),
                          delete: true,
                          cb: () => {
                                GetIt.I<AddressBloc>()
                                    .add(DeleteAddressEvent(location.id))
                              });
                    } else {
                      print(widget._fbAddressLocal.currentState.value);
                      print('validation failed');
                    }
                  },
                  child: Text(FlutterI18n.translate(
                      context, "account.address.deleteAddress")),
                  shape:
                      CircleBorder(side: BorderSide(color: Colors.transparent)),
                ),
              ),
        SizedBox(
          width: 264,
          child: AppButton(
            widget.isNew
                ? FlutterI18n.translate(context, "account.address.addAddress")
                : FlutterI18n.translate(context, "account.address.editAddress"),
            () {
              if (widget._fbAddressLocal.currentState.saveAndValidate()) {
                print(widget._fbAddressLocal.currentState.value);
                FocusScope.of(context).requestFocus(new FocusNode());

                Location body = Location.fromJson(
                    widget._fbAddressLocal.currentState.value);
                body.locationType = isHome ? "HOME" : "OFFICE";
                body.id = location != null && location.id != null
                    ? location.id
                    : null;

                print("Set Address Op");
                print("id ${body.id}");
                print("phoneNo ${body.phoneNo}");
                print("countryCode ${body.countryCode}");
                print("state ${body.state}");
                print("city ${body.city}");
                print("postcode ${body.postcode}");
                print("address ${body.address}");
                print("locationType ${body.locationType}");
                print("defaultShipping ${body.defaultShipping}");
                print("defaultBilling ${body.defaultBilling}");

                GetIt.I<AddressBloc>().add(SetAddressEvent(context, body));
              } else {
                print(widget._fbAddressLocal.currentState.value);
                print('validation failed');
              }
            },
            size: AppButtonSize.small,
            noPadding: true,
          ),
        ),
      ],
    );
  }
}
