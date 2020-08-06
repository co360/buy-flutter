import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get_it/get_it.dart';
import 'package:storeFlutter/blocs/account/address-bloc.dart';
import 'package:storeFlutter/components/list/city-list.dart';
import 'package:storeFlutter/components/list/country-list.dart';
import 'package:storeFlutter/components/list/state-list.dart';
import 'package:storeFlutter/models/label-value.dart';
import 'package:storeFlutter/util/app-theme.dart';
import 'package:storeFlutter/util/form-util.dart';

class DropDownAddressForm extends StatefulWidget {
  DropDownAddressForm({
    Key key,
  }) : super(key: key);

  @override
  _DropDownAddressFormState createState() => _DropDownAddressFormState();
}

class _DropDownAddressFormState extends State<DropDownAddressForm> {
  final _countryController = TextEditingController();
  final _stateController = TextEditingController();
  final _cityController = TextEditingController();

  String selectCountryCode;

  @override
  void initState() {
    print("[DropDownAddressForm] Initialize");

    _countryController.text = "None";
    _stateController.text = "None";
    _cityController.text = "None";
    selectCountryCode = "None";

    super.initState();
  }

  @override
  void dispose() {
    _countryController.dispose();
    super.dispose();
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
            selectCountryCode = state.address.countryCode;
            _countryController.text = state.address.countryName;
            _stateController.text = state.address.state;
            _cityController.text = state.address.city;
          });
        }
      },
      child: buildChild(context),
    );
  }

  _selectCountryEvt(BuildContext context) async {
    final result = await Navigator.push(
      context,
      CupertinoPageRoute(
        builder: (context) => CountryList(),
      ),
    );
    if (result != null && result.code != selectCountryCode) {
      setState(() {
        _countryController.text = result.label;
        selectCountryCode = result.code;
        _stateController.text = "None";
        _cityController.text = "None";
      });
    }
  }

  _selectStateEvt(BuildContext context) async {
    final result = await Navigator.push(
      context,
      CupertinoPageRoute(
        builder: (context) => StateList(selectCountryCode),
      ),
    );
    if (result != null && _stateController.text != result.label) {
      setState(() {
        _stateController.text = result.label;
        _cityController.text = "None";
      });
    }
  }

  _selectCityEvt(BuildContext context) async {
    final result = await Navigator.push(
      context,
      CupertinoPageRoute(
        builder: (context) => CityList(_stateController.text),
      ),
    );
    if (result != null && _cityController.text != result.label) {
      setState(() {
        _cityController.text = result.label;
      });
    }
  }

  Widget buildChild(BuildContext context) {
    print("[DropDownAddressForm] buildChild");
    return Column(
      children: <Widget>[
        GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTap: () {
            _selectCountryEvt(context);
          },
          child: FormBuilderTextField(
            attribute: 'countryCode',
            controller: _countryController,
            valueTransformer: (value) => selectCountryCode,
            readOnly: true,
            maxLines: 1,
            autocorrect: false,
            decoration: InputDecoration(
              suffixIcon: Container(
                padding: EdgeInsets.only(top: 20, left: 30),
                child: FaIcon(
                  FontAwesomeIcons.lightChevronRight,
                  size: 15,
                ),
              ),
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: AppTheme.colorGray2),
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: AppTheme.colorGray2),
              ),
              disabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: AppTheme.colorGray2),
              ),
              labelText:
                  FlutterI18n.translate(context, "account.address.country"),
            ),
            validators: [
              FormUtil.required(context),
              (val) {
                if (val == "None")
                  return FlutterI18n.translate(context, "error.required");
              }
            ],
            keyboardType: TextInputType.text,
          ),
        ),
        SizedBox(height: 10),
        GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTap: () {
            _selectStateEvt(context);
          },
          child: FormBuilderTextField(
            attribute: 'state',
            controller: _stateController,
            readOnly: true,
            maxLines: 1,
            autocorrect: false,
            decoration: InputDecoration(
              suffixIcon: Container(
                padding: EdgeInsets.only(top: 20, left: 30),
                child: FaIcon(
                  FontAwesomeIcons.lightChevronRight,
                  size: 15,
                ),
              ),
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: AppTheme.colorGray2),
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: AppTheme.colorGray2),
              ),
              disabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: AppTheme.colorGray2),
              ),
              labelText:
                  FlutterI18n.translate(context, "account.address.state"),
            ),
            validators: [
              FormUtil.required(context),
              (val) {
                if (val == "None")
                  return FlutterI18n.translate(context, "error.required");
              }
            ],
            keyboardType: TextInputType.text,
          ),
        ),
        SizedBox(height: 10),
        GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTap: () {
            _selectCityEvt(context);
          },
          child: FormBuilderTextField(
            attribute: 'city',
            controller: _cityController,
            readOnly: true,
            maxLines: 1,
            autocorrect: false,
            decoration: InputDecoration(
              suffixIcon: Container(
                padding: EdgeInsets.only(top: 20, left: 30),
                child: FaIcon(
                  FontAwesomeIcons.lightChevronRight,
                  size: 15,
                ),
              ),
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: AppTheme.colorGray2),
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: AppTheme.colorGray2),
              ),
              disabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: AppTheme.colorGray2),
              ),
              labelText: FlutterI18n.translate(context, "account.address.city"),
            ),
            validators: [
              FormUtil.required(context),
              (val) {
                if (val == "None")
                  return FlutterI18n.translate(context, "error.required");
              }
            ],
            keyboardType: TextInputType.text,
          ),
        ),
      ],
    );
  }
}
