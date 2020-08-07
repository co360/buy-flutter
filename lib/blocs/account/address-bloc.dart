import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:storeFlutter/models/identity/company-profile.dart';
import 'package:storeFlutter/models/identity/country.dart';
import 'package:storeFlutter/services/company-profile-service.dart';
import 'package:storeFlutter/models/identity/location.dart';
import 'package:storeFlutter/services/country-service.dart';

// bloc
class AddressBloc extends Bloc<AddressEvent, AddressState> {
  final CompanyProfileService _companyProfileService =
      GetIt.I<CompanyProfileService>();
  final CountryService _countryService = GetIt.I<CountryService>();
  CompanyProfile _companyProfile;

  AddressBloc() : super(AddressInitial());

  @override
  Stream<AddressState> mapEventToState(AddressEvent event) async* {
    try {
      if (event is GetAddressEvent) {
        yield GetAddressInProgress();

        _companyProfile = await _companyProfileService.findByCompany(event.id);
        print("=================> $_companyProfile");
        if (_companyProfile != null) {
          List<Location> locations = [];
          for (var f in _companyProfile.locations) {
            Country country =
                await _countryService.getCountryByCode(f.countryCode);
            f.countryName = country.name;
            locations.add(f);
          }
          yield GetAddressSuccess(locations);
        } else {
          yield GetAddressFailed();
        }
      } else if (event is SetAddressEvent) {
        yield SetAddressInProgress();
        CompanyProfile tmpProfile = _companyProfile;

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

        for (var i = 0; i < tmpProfile.locations.length; i++) {
          if (setDefaultShipping) {
            tmpProfile.locations[i].defaultShipping = false;
          }
          if (setDefaultBilling) {
            tmpProfile.locations[i].defaultBilling = false;
          }
          if (event.location.id != null &&
              tmpProfile.locations[i].id == event.location.id) {
            tmpProfile.locations[i] = event.location;
            Country country = await _countryService
                .getCountryByCode(tmpProfile.locations[i].countryCode);
            tmpProfile.locations[i].countryName = country.name;

            isNew = false;
          }
        }

        if (isNew) {
          tmpProfile.locations.add(event.location);
          Country country = await _countryService.getCountryByCode(tmpProfile
              .locations[tmpProfile.locations.length - 1].countryCode);
          tmpProfile.locations[tmpProfile.locations.length - 1].countryName =
              country.name;
        }

        _companyProfile =
            await _companyProfileService.updateCompanyProfile(tmpProfile);
        if (_companyProfile != null) {
          yield SetAddressSuccess();
        } else {
          yield SetAddressFailed();
        }
      } else if (event is DeleteAddressEvent) {
        yield DeleteAddressInProgress();
        List<Location> newLocations = [];
        CompanyProfile tmpProfile = _companyProfile;

        for (var i = 0; i < tmpProfile.locations.length; i++) {
          if (tmpProfile.locations[i].id != event.id) {
            newLocations.add(tmpProfile.locations[i]);
          }
        }
        tmpProfile.locations = newLocations;

        _companyProfile =
            await _companyProfileService.updateCompanyProfile(tmpProfile);
        if (_companyProfile != null) {
          yield DeleteAddressSuccess();
        } else {
          yield DeleteAddressFailed();
        }
      } else if (event is GetAddressByIDEvent) {
        yield GetAddressInProgress();
        Location location;
        for (var f in _companyProfile.locations) {
          if (f.id == event.id) {
            location = f;
            break;
          }
        }
        if (location != null) {
          yield GetAddressByIDSuccess(
              location, _companyProfile.locations.length);
        } else {
          GetAddressByIDFailed();
        }
      } else if (event is SetAddressHomeEvent) {
        yield SetAddressHomeSuccess(event.isHome);
      } else {
        yield AddressInitial();
      }
    } catch (e) {
      print("Error");
      print(e);
      yield AddressOpFailed(e);
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

class AddressOpFailed extends AddressState {
  final String error;
  AddressOpFailed(this.error);

  @override
  List<Object> get props => [error];
}

class GetAddressInProgress extends AddressState {}

class SetAddressInProgress extends AddressState {}

class DeleteAddressInProgress extends AddressState {}

class GetAddressSuccess extends AddressState {
  final List<Location> addresses;
  GetAddressSuccess(this.addresses);

  @override
  List<Object> get props => [addresses];
}

class GetAddressFailed extends AddressState {}

class GetAddressByIDSuccess extends AddressState {
  final Location address;
  final int total;
  GetAddressByIDSuccess(this.address, this.total);

  @override
  List<Object> get props => [address, total];
}

class GetAddressByIDFailed extends AddressState {}

class SetAddressSuccess extends AddressState {}

class SetAddressFailed extends AddressState {}

class SetAddressHomeSuccess extends AddressState {
  final bool isHome;
  SetAddressHomeSuccess(this.isHome);

  @override
  List<Object> get props => [isHome];
}

class SetAddressHomeFailed extends AddressState {}

class DeleteAddressSuccess extends AddressState {}

class DeleteAddressFailed extends AddressState {}

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
