import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:storeFlutter/blocs/account/address-bloc.dart';
import 'package:country_provider/country_provider.dart';
import 'package:storeFlutter/models/label-value.dart';

class DropDownAddressForm extends StatefulWidget {
  DropDownAddressForm({
    Key key,
  }) : super(key: key);

  @override
  _DropDownAddressFormState createState() => _DropDownAddressFormState();
}

class _DropDownAddressFormState extends State<DropDownAddressForm> {
  List<Country> countries = [];
  List<LabelValue> states = [];
  List<LabelValue> cities = [];

  String selectCountry;
  String selectState;
  String selectCity;

  @override
  void initState() {
    print("[DropDownAddressForm] Initialize");
    selectCountry = "None";
    selectState = "None";
    selectCity = "None";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AddressBloc, AddressState>(
      bloc: GetIt.I<AddressBloc>(),
      listener: (context, state) {
        print("[DropDownAddressForm] BlocListener");
        if (state is GetAddressByIDSuccess) {
          print("[DropDownAddressForm] GetAddressByIDSuccess");
          setState(() {
            countries = state.countries;
            states = state.states;
            cities = state.cities;
            selectCountry = state.address.countryCode;
            selectState = state.address.state;
            selectCity = state.address.city;
          });
        } else if (state is GetCountryListSuccess) {
          print("[DropDownAddressForm] GetCountryListSuccess");
          setState(() {
            countries = state.country;
            selectCountry = "None";
            selectState = "None";
            selectCity = "None";
            states = [];
            cities = [];
          });
        } else if (state is GetStateListSuccess) {
          print("[DropDownAddressForm] GetStateListSuccess");
          setState(() {
            selectState = "None";
            selectCity = "None";
            states = state.state;
            cities = [];
          });
        } else if (state is GetCityListSuccess) {
          setState(() {
            selectCity = "None";
            cities = state.city;
          });
        }
        print("City: $selectCity (${cities.length})");
        print("State: $selectState (${states.length})");
        print("Country: $selectCountry (${countries.length})");
      },
      child: buildChild(context),
    );
  }

  Widget buildChild(BuildContext context) {
    print("[DropDownAddressForm] buildChild");
    return Column(
      children: <Widget>[
        FormBuilderDropdown(
          key: UniqueKey(),
          attribute: "countryCode",
          initialValue: countries == null || countries.length == 0
              ? "None"
              : selectCountry,
          elevation: 16,
          decoration: InputDecoration(
              labelText:
                  FlutterI18n.translate(context, "account.address.country")),
          hint: Text(
              FlutterI18n.translate(context, "account.address.selectCountry")),
          validators: [
            FormBuilderValidators.required(),
            (val) {
              if (val == "None")
                return FlutterI18n.translate(context, "error.required");
            }
          ],
          onChanged: (val) {
            print("onChanged Country $val");
            selectCountry = val;
            GetIt.I<AddressBloc>().add(GetStateListEvent(val));
          },
          items: countries == null || countries.length == 0
              ? [DropdownMenuItem(value: "None", child: Text("None"))]
              : [
                  DropdownMenuItem(value: "None", child: Text("None")),
                  ...countries
                      .map((country) => DropdownMenuItem(
                          value: country.alpha2Code,
                          child: Text("${country.name}")))
                      .toList()
                ],
        ),
        SizedBox(height: 10),
        FormBuilderDropdown(
          key: UniqueKey(),
          attribute: "state",
          initialValue:
              states == null || states.length == 0 ? "None" : selectState,
          decoration: InputDecoration(
              labelText:
                  FlutterI18n.translate(context, "account.address.state")),
          hint: Text(
              FlutterI18n.translate(context, "account.address.selectState")),
          elevation: 16,
          validators: [
            FormBuilderValidators.required(),
            (val) {
              if (val == "None")
                return FlutterI18n.translate(context, "error.required");
            }
          ],
          onChanged: (val) {
            selectState = val;
            GetIt.I<AddressBloc>().add(GetCityListEvent(val));
          },
          items: states == null || states.length == 0
              ? [DropdownMenuItem(value: "None", child: Text("None"))]
              : [
                  DropdownMenuItem(value: "None", child: Text("None")),
                  ...states
                      .map((state) => DropdownMenuItem(
                          value: state.value, child: Text("${state.label}")))
                      .toList()
                ],
        ),
        SizedBox(height: 10),
        FormBuilderDropdown(
          key: UniqueKey(),
          attribute: "city",
          initialValue:
              cities == null || cities.length == 0 ? "None" : selectCity,
          elevation: 16,
          decoration: InputDecoration(
              labelText:
                  FlutterI18n.translate(context, "account.address.city")),
          hint: Text(
              FlutterI18n.translate(context, "account.address.selectCity")),
          validators: [
            FormBuilderValidators.required(),
            (val) {
              if (val == "None")
                return FlutterI18n.translate(context, "error.required");
            }
          ],
          onChanged: (val) {
            selectCity = val;
          },
          items: cities == null || cities.length == 0
              ? [DropdownMenuItem(value: "None", child: Text("None"))]
              : [
                  DropdownMenuItem(value: "None", child: Text("None")),
                  ...cities
                      .map((city) => DropdownMenuItem(
                          value: city.value, child: Text("${city.label}")))
                      .toList()
                ],
        ),
      ],
    );
  }
}
