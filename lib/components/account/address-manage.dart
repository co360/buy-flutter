import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:get_it/get_it.dart';
import 'package:storeFlutter/blocs/account/address-bloc.dart';
import 'package:storeFlutter/components/app-button.dart';
import 'package:storeFlutter/components/app-notification.dart';
import 'package:storeFlutter/models/label-value.dart';
import 'package:storeFlutter/models/identity/location.dart';
import 'package:storeFlutter/util/app-theme.dart';
import 'package:storeFlutter/util/form-util.dart';
import 'package:storeFlutter/services/storage-service.dart';
import 'package:storeFlutter/services/address-service.dart';
import 'package:country_provider/country_provider.dart';
import 'package:auto_size_text/auto_size_text.dart';

class AddressManage extends StatelessWidget {
  final GlobalKey<FormBuilderState> _fbAddress = GlobalKey<FormBuilderState>();
  final StorageService storageService = GetIt.I<StorageService>();
  final bool isNew;
  final Location location;
  final List<Country> countries;
  final List<LabelValue> states;
  final List<LabelValue> cities;
  final bool _isHome;
  final String _country;
  final String _state;
  final String _city;
  final Function(int, String) setParams;

  String countryName = "";

  AddressManage(
      this.isNew,
      this.location,
      this.countries,
      this.states,
      this.cities,
      this._country,
      this._state,
      this._city,
      this._isHome,
      this.setParams);

  @override
  Widget build(BuildContext context) {
    return BlocListener<AddressBloc, AddressState>(
      bloc: GetIt.I<AddressBloc>(),
      listener: (context, state) {
        print("current state $state");
        if (state is ManageAddressFailed) {
          AppNotification(FlutterI18n.translate(context, "error.notExist"))
              .show(context);
          GetIt.I<AddressBloc>().add(InitAddressEvent());
        } else if (state is SetAddressSuccess) {
          Navigator.pop(context);
        } else if (state is DeleteAddressSuccess) {
          Navigator.pop(context);
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
                  FormBuilderTextField(
                    attribute: 'fullName',
                    initialValue: location == null || location.fullName == null
                        ? storageService.loginUser.firstName
                        : location.fullName,
                    maxLines: 1,
                    autocorrect: false,
                    decoration: InputDecoration(
                      enabledBorder: AppTheme.formInputEnabledBorder,
                      focusedBorder: AppTheme.formInputFocusedBorder,
                      labelText: FlutterI18n.translate(
                          context, "account.address.fullName"),
                    ),
                    validators: [
                      FormUtil.required(context),
                    ],
                    keyboardType: TextInputType.text,
                  ),
                  SizedBox(height: 10),
                  FormBuilderTextField(
                    attribute: 'phoneNo',
                    initialValue: location == null || location.phoneNo == null
                        ? storageService.loginUser.contactNo
                        : location.phoneNo,
                    maxLines: 1,
                    autocorrect: false,
                    decoration: InputDecoration(
                      enabledBorder: AppTheme.formInputEnabledBorder,
                      focusedBorder: AppTheme.formInputFocusedBorder,
                      labelText: FlutterI18n.translate(
                          context, "account.address.phoneNumber"),
                    ),
                    validators: [
                      FormUtil.required(context),
                    ],
                    keyboardType: TextInputType.phone,
                  ),
                  SizedBox(height: 10),
                  FormBuilderDropdown(
                    attribute: "countryCode",
                    initialValue: countries == null || countries.length == 0
                        ? "None"
                        : _country != null ? _country : "MY",
                    elevation: 16,
                    decoration: InputDecoration(
                        labelText: FlutterI18n.translate(
                            context, "account.address.country")),
                    hint: Text(FlutterI18n.translate(
                        context, "account.address.selectCountry")),
                    validators: [FormBuilderValidators.required()],
                    onChanged: (val) {
                      print("onChanged Country $val");
                      setParams(0, val);
                      GetIt.I<AddressBloc>().add(GetStateListEvent(val));
                    },
                    items: countries == null || countries.length == 0
                        ? [DropdownMenuItem(value: "None", child: Text("None"))]
                        : [
                            DropdownMenuItem(
                                value: "None", child: Text("None")),
                            ...countries
                                .map((country) => DropdownMenuItem(
                                    value: country.alpha2Code,
                                    child: Text("${country.name}")))
                                .toList()
                          ],
                  ),
                  SizedBox(height: 10),
                  FormBuilderDropdown(
                    attribute: "state",
                    initialValue:
                        states == null || states.length == 0 ? "None" : _state,
                    decoration: InputDecoration(
                        labelText: FlutterI18n.translate(
                            context, "account.address.state")),
                    hint: Text(FlutterI18n.translate(
                        context, "account.address.selectState")),
                    elevation: 16,
                    validators: [FormBuilderValidators.required()],
                    onChanged: (val) {
                      setParams(1, val);
                      GetIt.I<AddressBloc>().add(GetCityListEvent(val));
                    },
                    items: states == null || states.length == 0
                        ? [DropdownMenuItem(value: "None", child: Text("None"))]
                        : [
                            DropdownMenuItem(
                                value: "None", child: Text("None")),
                            ...states
                                .map((state) => DropdownMenuItem(
                                    value: state.value,
                                    child: Text("${state.label}")))
                                .toList()
                          ],
                  ),
                  SizedBox(height: 10),
                  FormBuilderDropdown(
                    attribute: "city",
                    initialValue:
                        cities == null || cities.length == 0 ? "None" : _city,
                    elevation: 16,
                    decoration: InputDecoration(
                        labelText: FlutterI18n.translate(
                            context, "account.address.city")),
                    hint: Text(FlutterI18n.translate(
                        context, "account.address.selectCity")),
                    validators: [FormBuilderValidators.required()],
                    onChanged: (val) {
                      setParams(2, val);
                    },
                    items: cities == null || cities.length == 0
                        ? [DropdownMenuItem(value: "None", child: Text("None"))]
                        : [
                            DropdownMenuItem(
                                value: "None", child: Text("None")),
                            ...cities
                                .map((city) => DropdownMenuItem(
                                    value: city.value,
                                    child: Text("${city.label}")))
                                .toList()
                          ],
                  ),
                  SizedBox(height: 10),
                  FormBuilderTextField(
                    attribute: 'postcode',
                    initialValue: location == null || location.postcode == null
                        ? ""
                        : location.postcode,
                    maxLines: 1,
                    autocorrect: false,
                    decoration: InputDecoration(
                      enabledBorder: AppTheme.formInputEnabledBorder,
                      focusedBorder: AppTheme.formInputFocusedBorder,
                      labelText: FlutterI18n.translate(
                          context, "account.address.postcode"),
                    ),
                    validators: [
                      FormUtil.required(context),
                    ],
                    keyboardType: TextInputType.text,
                  ),
                  SizedBox(height: 10),
                  FormBuilderTextField(
                    attribute: 'address',
                    initialValue: location == null || location.address == null
                        ? ""
                        : location.address,
                    maxLines: 1,
                    autocorrect: false,
                    decoration: InputDecoration(
                      enabledBorder: AppTheme.formInputEnabledBorder,
                      focusedBorder: AppTheme.formInputFocusedBorder,
                      labelText: FlutterI18n.translate(
                          context, "account.address.address"),
                    ),
                    validators: [
                      FormUtil.required(context),
                    ],
                    keyboardType: TextInputType.text,
                  ),
                  SizedBox(height: 15)
                ],
              ),
            ),
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
                          FlutterI18n.translate(
                              context, "account.address.selectLabel"),
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
                              onPressed: () => {setParams(3, "true")},
                              color: _isHome
                                  ? AppTheme.colorPrimary
                                  : AppTheme.colorGray1,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              child: AutoSizeText(
                                  FlutterI18n.translate(
                                      context, "account.address.home"),
                                  minFontSize: 12,
                                  style: TextStyle(
                                    color:
                                        _isHome ? Colors.white : Colors.black,
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
                              onPressed: () => {setParams(3, "false")},
                              color: !_isHome
                                  ? AppTheme.colorPrimary
                                  : AppTheme.colorGray1,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              child: AutoSizeText(
                                  FlutterI18n.translate(
                                      context, "account.address.office"),
                                  minFontSize: 12,
                                  style: TextStyle(
                                    color:
                                        !_isHome ? Colors.white : Colors.black,
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                  )),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                )),
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
                        label: Text(FlutterI18n.translate(context,
                            "account.address.makeDefaultBillingAddress")),
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
            isNew
                ? Container()
                : Container(
                    color: Colors.white,
                    margin: const EdgeInsets.only(top: 10, bottom: 10),
                    // padding: const EdgeInsets.all(10),
                    alignment: Alignment.centerLeft,
                    child: FlatButton(
                      textColor: AppTheme.colorDanger,
                      onPressed: () {
                        if (_fbAddress.currentState.saveAndValidate()) {
                          print(_fbAddress.currentState.value);
                          FocusScope.of(context).requestFocus(new FocusNode());

                          Location body =
                              Location.fromJson(_fbAddress.currentState.value);
                          body.name = _isHome ? "Home" : "Office";
                          body.id = location.id;
                          print(body);
                          print(body.id);
                          print(body.countryCode);

                          GetIt.I<AddressBloc>().add(DeleteAddressEvent(body));
                        } else {
                          print(_fbAddress.currentState.value);
                          print('validation failed');
                        }
                      },
                      child: Text(FlutterI18n.translate(
                          context, "account.address.deleteAddress")),
                      shape: CircleBorder(
                          side: BorderSide(color: Colors.transparent)),
                    ),
                  ),
            SizedBox(
              width: 264,
              child: AppButton(
                isNew
                    ? FlutterI18n.translate(
                        context, "account.address.addAddress")
                    : FlutterI18n.translate(
                        context, "account.address.editAddress"),
                () {
                  if (_fbAddress.currentState.saveAndValidate()) {
                    print(_fbAddress.currentState.value);
                    FocusScope.of(context).requestFocus(new FocusNode());

                    Location body =
                        Location.fromJson(_fbAddress.currentState.value);
                    body.name = _isHome ? "Home" : "Office";
                    body.id = location != null && location.id != null
                        ? location.id
                        : null;
                    print(body);
                    print(body.id);
                    print(body.countryCode);

                    GetIt.I<AddressBloc>().add(SetAddressEvent(body));
                  } else {
                    print(_fbAddress.currentState.value);
                    print('validation failed');
                  }
                },
                size: AppButtonSize.small,
                noPadding: true,
              ),
            ),
            SizedBox(height: 10)
          ],
        ),
      ),
    );
  }
}
