import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:get_it/get_it.dart';
import 'package:storeFlutter/blocs/account/address-bloc.dart';
import 'package:storeFlutter/components/account/address-manage.dart';
import 'package:storeFlutter/models/label-value.dart';
import 'package:storeFlutter/models/identity/location.dart';
import 'package:storeFlutter/services/storage-service.dart';
import 'package:storeFlutter/services/address-service.dart';
import 'package:country_provider/country_provider.dart';

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

  @override
  void initState() {
    print("Initialize Manage Address Screen and State : ${widget.id}");
    if (widget.id != null && widget.id != 0) {
      print("widget id: ${widget.id}");
      GetIt.I<AddressBloc>().add(GetAddressByIDEvent(widget.id));
    } else {
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
                  case GetCountryListSuccess:
                    {
                      print("State GetCountryListSuccess");
                      print(state.props);
                      countries = state.props[0];
                      GetIt.I<AddressBloc>().add(InitAddressEvent());

                      break;
                    }
                  case GetAddressByIDSuccess:
                    {
                      print("State GetAddressByIDSuccess");
                      print(state.props);
                      location = state.props[0];
                      countries = state.props[1];
                      selectCountry = location.countryCode;
                      selectState = location.state;
                      selectCity = location.city;
                      if (states.length == 0 && selectCountry != null) {
                        GetIt.I<AddressBloc>()
                            .add(GetStateListEvent(selectCountry));
                      } else {
                        GetIt.I<AddressBloc>().add(InitAddressEvent());
                      }
                      break;
                    }
                  case GetStateListSuccess:
                    {
                      print(state.props);
                      states = state.props[0];
                      if (cities.length == 0 && selectState != null) {
                        GetIt.I<AddressBloc>()
                            .add(GetCityListEvent(selectState));
                      } else {
                        GetIt.I<AddressBloc>().add(InitAddressEvent());
                      }
                      break;
                    }
                  case GetCityListSuccess:
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

  void _setParams(int sel, var param) {
    switch (sel) {
      case 0:
        if (param != selectCountry) {
          setState(() {
            selectCountry = param;
            selectState = "None";
            selectCity = "None";
          });
        }
        break;
      case 1:
        if (param != selectState) {
          setState(() {
            selectState = param;
            selectCity = "None";
          });
        }
        break;
      case 2:
        if (param != selectCity) {
          setState(() {
            selectCity = param;
          });
        }
        break;
      case 3:
        setState(() {
          isHome = param == "true" ? true : false;
        });
        break;
      default:
        break;
    }
  }
}
