import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:storeFlutter/services/address-service.dart';
import 'package:storeFlutter/models/identity/location.dart';
import 'package:storeFlutter/models/label-value.dart';
import 'package:country_provider/country_provider.dart';

// bloc
class AddressBloc extends Bloc<AddressEvent, AddressState> {
  final AddressService _addressService = GetIt.I<AddressService>();

  AddressBloc() : super(AddressInitial());

  @override
  Stream<AddressState> mapEventToState(AddressEvent event) async* {
    try {
      if (event is GetAddressEvent) {
        yield AddressInProgress();
        List<Location> status = await _addressService.getAddress(event.id);
        if (status != null) {
          yield GetAddressSuccess(status);
        }
      } else if (event is SetAddressEvent) {
        yield AddressInProgress();
        List<Location> status = await _addressService.setAddress(event.body);
        if (status != null) {
          yield SetAddressSuccess(status);
        }
      } else if (event is DeleteAddressEvent) {
        yield AddressInProgress();
        List<Location> status = await _addressService.deleteAddress(event.body);
        if (status != null) {
          yield DeleteAddressSuccess(status);
        }
      } else if (event is GetAddressByIDEvent) {
        yield AddressInProgress();
        Location status = await _addressService.getAddressByID(event.id);
        List<Country> statusCountries = await _addressService.getCountryList();
        List<LabelValue> statusStates =
            await _addressService.getStateList(status.countryCode);
        List<LabelValue> statusCities =
            await _addressService.getCityList(status.state);
        if (status != null) {
          yield GetAddressByIDSuccess(
              status, statusCountries, statusStates, statusCities);
        }
      } else if (event is GetCityListEvent) {
        yield AddressInProgress();
        List<LabelValue> status =
            await _addressService.getCityList(event.state);
        yield GetCityListSuccess(status);
      } else if (event is GetStateListEvent) {
        yield AddressInProgress();
        List<LabelValue> status =
            await _addressService.getStateList(event.country);
        print(status);
        yield GetStateListSuccess(status);
      } else if (event is GetCountryListEvent) {
        yield AddressInProgress();
        List<Country> status = await _addressService.getCountryList();
        yield GetCountryListSuccess(status);
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
  final List<Country> countries;
  final List<LabelValue> states;
  final List<LabelValue> cities;
  GetAddressByIDSuccess(this.address, this.countries, this.states, this.cities);

  @override
  List<Object> get props => [address, countries, this.states, this.cities];
}

class GetCityListSuccess extends AddressState {
  final List<LabelValue> city;
  GetCityListSuccess(this.city);

  @override
  List<Object> get props => [city];
}

class GetCountryListSuccess extends AddressState {
  final List<Country> country;
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

class SetAddressSuccess extends AddressState {
  final List<Location> addresses;
  SetAddressSuccess(this.addresses);

  @override
  List<Object> get props => [addresses];
}

class DeleteAddressSuccess extends AddressState {
  final List<Location> addresses;
  DeleteAddressSuccess(this.addresses);

  @override
  List<Object> get props => [addresses];
}

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

  GetAddressByIDEvent(this.id);

  @override
  List<Object> get props => [id];
}

class GetStateListEvent extends AddressEvent {
  final String country;
  GetStateListEvent(this.country);

  @override
  List<Object> get props => [country];
}

class GetCityListEvent extends AddressEvent {
  final String state;
  GetCityListEvent(this.state);

  @override
  List<Object> get props => [state];
}

class GetCountryListEvent extends AddressEvent {}

class SetAddressEvent extends AddressEvent {
  final Location body;

  SetAddressEvent(this.body);

  @override
  List<Object> get props => [body];
}

class DeleteAddressEvent extends AddressEvent {
  final Location body;

  DeleteAddressEvent(this.body);

  @override
  List<Object> get props => [body];
}

class InitAddressEvent extends AddressEvent {}
