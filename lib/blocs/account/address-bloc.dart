import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:storeFlutter/models/identity/company-profile.dart';
import 'package:storeFlutter/models/identity/country.dart';
import 'package:storeFlutter/services/company-profile-service.dart';
import 'package:storeFlutter/datasource/country-data-source.dart';
import 'package:storeFlutter/datasource/state-data-source.dart';
import 'package:storeFlutter/datasource/city-data-source.dart';
import 'package:storeFlutter/models/identity/location.dart';
import 'package:storeFlutter/models/label-value.dart';
import 'package:storeFlutter/services/country-service.dart';

// bloc
class AddressBloc extends Bloc<AddressEvent, AddressState> {
  final CompanyProfileService _companyProfileService =
      GetIt.I<CompanyProfileService>();
  final CountryService _countryService = GetIt.I<CountryService>();
  final CountryDataSource _countryDataSource = GetIt.I<CountryDataSource>();
  final StateDataSource _stateDataSource = GetIt.I<StateDataSource>();
  final CityDataSource _cityDataSource = GetIt.I<CityDataSource>();
  CompanyProfile _companyProfile;

  AddressBloc() : super(AddressInitial());

  @override
  Stream<AddressState> mapEventToState(AddressEvent event) async* {
    try {
      if (event is GetAddressEvent) {
        yield AddressInProgress();
        _companyProfile = await _companyProfileService.findByCompany(event.id);
        if (_companyProfile != null) {
          List<Location> locations = [];
          for (var f in _companyProfile.locations) {
            Country country =
                await _countryService.getCountryByCode(f.countryCode);
            f.countryName = country.name;
            locations.add(f);
          }
          yield GetAddressSuccess(locations);
        }
      } else if (event is SetAddressEvent) {
        yield AddressInProgress();
        CompanyProfile tempCompanyProfile = _companyProfile;

        List<LabelValue> _countries =
            await _countryDataSource.getDataSource(event.context);

        // Reconfigure the parameters
        event.location.defaultShipping = event.location.defaultShipping == null
            ? true
            : event.location.defaultShipping;
        event.location.defaultBilling = event.location.defaultBilling == null
            ? true
            : event.location.defaultBilling;

        bool isNew = true;
        bool setDefaultShipping = event.location.defaultShipping;
        bool setDefaultBilling = event.location.defaultBilling;

        for (var i = 0; i < tempCompanyProfile.locations.length; i++) {
          if (setDefaultShipping) {
            tempCompanyProfile.locations[i].defaultShipping = false;
          }
          if (setDefaultBilling) {
            tempCompanyProfile.locations[i].defaultBilling = false;
          }
          if (event.location.id != null &&
              tempCompanyProfile.locations[i].id == event.location.id) {
            tempCompanyProfile.locations[i] = event.location;
            for (var f in _countries) {
              if (f.label == tempCompanyProfile.locations[i].countryCode) {
                tempCompanyProfile.locations[i].countryName = f.label;
                break;
              }
            }
            isNew = false;
          }
        }

        if (isNew) {
          tempCompanyProfile.locations.add(event.location);
          for (var f in _countries) {
            if (f.code ==
                tempCompanyProfile
                    .locations[tempCompanyProfile.locations.length - 1]
                    .countryCode) {
              tempCompanyProfile
                  .locations[tempCompanyProfile.locations.length - 1]
                  .countryName = f.label;
              break;
            }
          }
        }

        _companyProfile = await _companyProfileService
            .updateCompanyProfile(tempCompanyProfile);
        if (_companyProfile != null) {
          yield SetAddressSuccess();
        }
      } else if (event is DeleteAddressEvent) {
        List<Location> newLocations = [];
        CompanyProfile tempCompanyProfile = _companyProfile;

        for (var i = 0; i < tempCompanyProfile.locations.length; i++) {
          if (tempCompanyProfile.locations[i].id != event.id) {
            newLocations.add(tempCompanyProfile.locations[i]);
          }
        }
        tempCompanyProfile.locations = newLocations;

        _companyProfile = await _companyProfileService
            .updateCompanyProfile(tempCompanyProfile);
        if (_companyProfile != null) {
          yield DeleteAddressSuccess();
        }
      } else if (event is GetAddressByIDEvent) {
        yield AddressInProgress();
        String tempCountry = "MY";
        String tempState = "Kuala Lumpur";
        Location location;
        for (var f in _companyProfile.locations) {
          if (f.id == event.id) {
            location = f;
            tempCountry = f.countryCode;
            tempState = f.state;
            break;
          }
        }
        List<LabelValue> _countries =
            await _countryDataSource.getDataSource(event.context);
        List<LabelValue> _states = await _stateDataSource
            .getDataSource(event.context, param: tempCountry);
        List<LabelValue> _cities = await _cityDataSource
            .getDataSource(event.context, param: tempState);
        yield GetAddressByIDSuccess(location, _countries, _states, _cities,
            _companyProfile.locations.length);
      } else if (event is GetCityListEvent) {
        yield AddressInProgress();
        List<LabelValue> _cities = await _cityDataSource
            .getDataSource(event.context, param: event.state);
        yield GetCityListSuccess(_cities);
      } else if (event is GetStateListEvent) {
        yield AddressInProgress();
        List<LabelValue> _states = await _stateDataSource
            .getDataSource(event.context, param: event.country);
        yield GetStateListSuccess(_states);
      } else if (event is SetAddressHomeEvent) {
        yield SetAddressHomeSuccess(event.isHome);
      } else if (event is GetCountryListEvent) {
        yield AddressInProgress();
        List<LabelValue> _countries =
            await _countryDataSource.getDataSource(event.context);
        yield GetCountryListSuccess(_countries);
      } else {
        yield AddressInitial();
      }
    } catch (e) {
      print("Error");
      print(e);
      yield ManageAddressFailed();
    }
  }
}

// state
abstract class AddressState extends Equatable {
  const AddressState();

  @override
  List<Object> get props => [];
}

class AddressInitial extends AddressState {}

class AddressInProgress extends AddressState {}

class GetAddressSuccess extends AddressState {
  final List<Location> addresses;
  GetAddressSuccess(this.addresses);

  @override
  List<Object> get props => [addresses];
}

class GetAddressByIDSuccess extends AddressState {
  final Location address;
  final List<LabelValue> countries;
  final List<LabelValue> states;
  final List<LabelValue> cities;
  final int total;
  GetAddressByIDSuccess(
      this.address, this.countries, this.states, this.cities, this.total);

  @override
  List<Object> get props => [address, countries, states, cities, total];
}

class GetCityListSuccess extends AddressState {
  final List<LabelValue> city;
  GetCityListSuccess(this.city);

  @override
  List<Object> get props => [city];
}

class GetCountryListSuccess extends AddressState {
  final List<LabelValue> country;
  GetCountryListSuccess(this.country);

  @override
  List<Object> get props => [country];
}

class GetStateListSuccess extends AddressState {
  final List<LabelValue> state;
  GetStateListSuccess(this.state);

  @override
  List<Object> get props => [state];
}

class SetAddressSuccess extends AddressState {}

class SetAddressHomeSuccess extends AddressState {
  final bool isHome;
  SetAddressHomeSuccess(this.isHome);

  @override
  List<Object> get props => [isHome];
}

class DeleteAddressSuccess extends AddressState {}

class ManageAddressFailed extends AddressState {}

// Event
abstract class AddressEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class GetAddressEvent extends AddressEvent {
  final int id;

  GetAddressEvent(this.id);

  @override
  List<Object> get props => [id];
}

class GetAddressByIDEvent extends AddressEvent {
  final int id;
  final BuildContext context;

  GetAddressByIDEvent(this.context, this.id);

  @override
  List<Object> get props => [context, id];
}

class GetStateListEvent extends AddressEvent {
  final BuildContext context;
  final String country;

  GetStateListEvent(this.context, this.country);

  @override
  List<Object> get props => [context, country];
}

class GetCityListEvent extends AddressEvent {
  final BuildContext context;
  final String state;

  GetCityListEvent(this.context, this.state);

  @override
  List<Object> get props => [context, state];
}

class GetCountryListEvent extends AddressEvent {
  final BuildContext context;

  GetCountryListEvent(this.context);

  @override
  List<Object> get props => [context];
}

class SetAddressEvent extends AddressEvent {
  final BuildContext context;
  final Location location;

  SetAddressEvent(this.context, this.location);

  @override
  List<Object> get props => [context, location];
}

class DeleteAddressEvent extends AddressEvent {
  final int id;

  DeleteAddressEvent(this.id);

  @override
  List<Object> get props => [id];
}

class SetAddressHomeEvent extends AddressEvent {
  final bool isHome;

  SetAddressHomeEvent(this.isHome);

  @override
  List<Object> get props => [isHome];
}

class InitAddressEvent extends AddressEvent {}
