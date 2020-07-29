import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:get_it/get_it.dart';
import 'package:storeFlutter/blocs/account/address-bloc.dart';
import 'package:storeFlutter/components/account/address-manage.dart';
import 'package:storeFlutter/models/date-type.dart';
import 'package:storeFlutter/models/label-value.dart';
import 'package:storeFlutter/models/identity/location.dart';
import 'package:storeFlutter/services/storage-service.dart';
import 'package:storeFlutter/services/address-service.dart';
import 'package:country_provider/country_provider.dart';
import 'package:storeFlutter/util/enums-util.dart';

class ManageAddressScreen extends StatefulWidget {
  final int id;

  ManageAddressScreen(this.id);
  @override
  _ManageAddressScreenState createState() => _ManageAddressScreenState();
}

class _ManageAddressScreenState extends State<ManageAddressScreen> {
  final StorageService storageService = GetIt.I<StorageService>();
  final AddressService addressService = GetIt.I<AddressService>();

  // Bloc State
  Location location;
  List<Country> countries = [];
  List<LabelValue> states = [];
  List<LabelValue> cities = [];

  // Local States
  bool isHome = true;
  String selectCountry = "None";
  String selectState = "None";
  String selectCity = "None";
  bool hasDialog = false;

  @override
  void initState() {
    print("Initialize Manage Address Screen and State : ${widget.id}");
    if (widget.id != null && widget.id != 0) {
      print("widget id: ${widget.id}");
      GetIt.I<AddressBloc>().add(GetAddressByIDEvent(widget.id));
    } else {
      print("call this");
      GetIt.I<AddressBloc>().add(GetCountryListEvent());
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
        child: SingleChildScrollView(
          child: BlocBuilder<AddressBloc, AddressState>(
              bloc: GetIt.I<AddressBloc>(),
              builder: (context, state) {
                print("current state $state");
                switch (state.runtimeType) {
                  case GetAddressByIDSuccess:
                    {
                      print("State GetAddressByIDSuccess");
                      print(state.props);
                      location = state.props[0];
                      countries = state.props[1];
                      states = state.props[2];
                      cities = state.props[3];
                      selectCountry = location.countryCode;
                      selectState = location.state;
                      selectCity = location.city;
                      isHome = location.locationType == "HOME" ? true : false;
                      GetIt.I<AddressBloc>().add(InitAddressEvent());
                      break;
                    }
                  case GetCountryListSuccess: // Get Country
                    {
                      print("State GetCountryListSuccess");
                      print("call this4");
                      print(state.props);
                      countries = state.props[0];
                      selectCountry = "MY";
                      if (states.length == 0 &&
                          selectCountry != null &&
                          selectCountry != "None") {
                        GetIt.I<AddressBloc>()
                            .add(GetStateListEvent(selectCountry));
                      } else {
                        GetIt.I<AddressBloc>().add(InitAddressEvent());
                      }

                      break;
                    }

                  case GetStateListSuccess: // Get State
                    {
                      print(state.props);
                      states = state.props[0];
                      if (cities.length == 0 &&
                          selectState != null &&
                          selectState != "None") {
                        GetIt.I<AddressBloc>()
                            .add(GetCityListEvent(selectState));
                      } else {
                        GetIt.I<AddressBloc>().add(InitAddressEvent());
                      }
                      break;
                    }
                  case GetCityListSuccess: // Get City
                    {
                      print(state.props);
                      cities = state.props[0];
                      GetIt.I<AddressBloc>().add(InitAddressEvent());
                      break;
                    }
                  default:
                    break;
                }
                print(selectCountry);
                print(selectState);
                print(selectCity);
                return AddressManage(
                    context,
                    hasDialog,
                    widget.id != null && widget.id == 0,
                    location,
                    countries,
                    states,
                    cities,
                    selectCountry,
                    selectState,
                    selectCity,
                    isHome,
                    _setParams);
              }),
        ),
      ),
    );
  }

  void _setParams(enumManageAddress sel, var param) {
    switch (sel) {
      case enumManageAddress.COUNTRY:
        if (param != selectCountry) {
          setState(() {
            selectCountry = param;
            selectState = "None";
            selectCity = "None";
          });
        }
        break;
      case enumManageAddress.STATE:
        if (param != selectState) {
          setState(() {
            selectState = param;
            selectCity = "None";
          });
        }
        break;
      case enumManageAddress.CITY:
        if (param != selectCity) {
          setState(() {
            selectCity = param;
          });
        }
        break;
      case enumManageAddress.HOME:
        setState(() {
          isHome = param == "true" ? true : false;
        });
        break;
      case enumManageAddress.DIALOG:
        setState(() {
          hasDialog = param == "true" ? true : false;
        });
        break;
      default:
        break;
    }
  }
}
