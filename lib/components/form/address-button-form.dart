import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:storeFlutter/services/storage-service.dart';
import 'package:storeFlutter/blocs/account/address-bloc.dart';
import 'package:storeFlutter/models/identity/location.dart';
import 'package:storeFlutter/util/app-theme.dart';
import 'package:storeFlutter/components/app-button.dart';

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
  bool isHome;

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
        Container(
            color: Colors.white,
            margin: const EdgeInsets.only(top: 10),
            padding: const EdgeInsets.only(left: 15, right: 10),
            child: Column(
              children: <Widget>[
                Container(
                  height: 50,
                  margin: const EdgeInsets.only(bottom: 10),
                  child: FormBuilderSwitch(
                    key: UniqueKey(),
                    label: Text(FlutterI18n.translate(
                        context, "account.address.makeDefaultShipping")),
                    attribute: "defaultShipping",
                    initialValue:
                        location == null || location.defaultShipping == null
                            ? false
                            : location.defaultShipping,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                    ),
                  ),
                ),
                Divider(
                  color: AppTheme.colorGray3,
                  height: 1,
                ),
                Container(
                  height: 50,
                  margin: const EdgeInsets.only(bottom: 10),
                  child: FormBuilderSwitch(
                    key: UniqueKey(),
                    label: Text(FlutterI18n.translate(
                        context, "account.address.makeDefaultBillingAddress")),
                    attribute: "defaultBilling",
                    initialValue:
                        location == null || location.defaultBilling == null
                            ? false
                            : location.defaultBilling,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ],
            )),
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

                      Location body = Location.fromJson(
                          widget._fbAddressLocal.currentState.value);
                      body.locationType = isHome ? "Home" : "Office";
                      body.id = location.id;

                      print("Delete Op");
                      print("id ${body.id}");

                      GetIt.I<AddressBloc>().add(DeleteAddressEvent(body));
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

                GetIt.I<AddressBloc>().add(SetAddressEvent(body));
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
