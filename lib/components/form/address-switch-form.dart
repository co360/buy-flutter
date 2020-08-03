import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:storeFlutter/blocs/account/address-bloc.dart';
import 'package:storeFlutter/util/app-theme.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:storeFlutter/models/identity/location.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class AddressSwitchForm extends StatefulWidget {
  AddressSwitchForm({
    Key key,
  }) : super(key: key);

  @override
  _AddressSwitchFormState createState() => _AddressSwitchFormState();
}

class _AddressSwitchFormState extends State<AddressSwitchForm> {
  bool isHome = true;
  bool isDefaultShipping = false;
  bool isDefaultBilling = false;

  @override
  void initState() {
    print("[AddressSwitchForm] Initialize");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AddressBloc, AddressState>(
      bloc: GetIt.I<AddressBloc>(),
      listener: (context, state) {
        print("[AddressSwitchForm] BlocListener");
        if (state is GetAddressByIDSuccess) {
          setState(() {
            isHome = state.address.locationType == "HOME" ? true : false;
            isDefaultShipping = state.address.defaultShipping;
            isDefaultBilling = state.address.defaultBilling;
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
    print("[AddressSwitchForm] buildChild");
    return Column(children: <Widget>[
      Container(
        color: Colors.white,
        alignment: Alignment.centerLeft,
        margin: const EdgeInsets.only(top: 10),
        padding: const EdgeInsets.all(10),
        child: Column(
          children: <Widget>[
            Container(
              alignment: Alignment.centerLeft,
              margin: const EdgeInsets.all(10),
              child: Text(
                  FlutterI18n.translate(context, "account.address.selectLabel"),
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 12,
                  )),
            ),
            Container(
              alignment: Alignment.centerLeft,
              margin: const EdgeInsets.all(10),
              child: Row(
                children: <Widget>[
                  SizedBox(
                    width: 100,
                    height: 57,
                    child: RaisedButton(
                      onPressed: () {
                        GetIt.I<AddressBloc>().add(SetAddressHomeEvent(true));
                      },
                      color:
                          isHome ? AppTheme.colorPrimary : AppTheme.colorGray1,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: AutoSizeText(
                          FlutterI18n.translate(
                              context, "account.address.home"),
                          minFontSize: 12,
                          style: TextStyle(
                            color: isHome ? Colors.white : Colors.black,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          )),
                    ),
                  ),
                  SizedBox(width: 15),
                  SizedBox(
                    width: 100,
                    height: 57,
                    child: RaisedButton(
                      onPressed: () {
                        GetIt.I<AddressBloc>().add(SetAddressHomeEvent(false));
                      },
                      color:
                          !isHome ? AppTheme.colorPrimary : AppTheme.colorGray1,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: AutoSizeText(
                          FlutterI18n.translate(
                              context, "account.address.office"),
                          minFontSize: 12,
                          style: TextStyle(
                            color: !isHome ? Colors.white : Colors.black,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          )),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
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
                  onChanged: (value) {
                    setState(() {
                      isDefaultShipping = value;
                    });
                  },
                  initialValue:
                      isDefaultShipping == null ? false : isDefaultShipping,
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
                  onChanged: (value) {
                    setState(() {
                      isDefaultBilling = value;
                    });
                  },
                  initialValue:
                      isDefaultBilling == null ? false : isDefaultBilling,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                  ),
                ),
              ),
            ],
          )),
    ]);
  }
}
