import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:storeFlutter/datasource/country-data-source.dart';
import 'package:storeFlutter/services/country-service.dart';
import 'package:storeFlutter/models/label-value.dart';
import 'package:storeFlutter/models/identity/country.dart';

// bloc
class CountryBloc extends Bloc<CountryEvent, CountryState> {
  final CountryService _countryService = GetIt.I<CountryService>();
  CountryDataSource _countryDataSource = GetIt.I<CountryDataSource>();

  CountryBloc() : super(CountryInitial());

  @override
  Stream<CountryState> mapEventToState(CountryEvent event) async* {
    try {
      if (event is GetCountryListEvent) {
        yield GetCountryListSuccess(
            await _countryDataSource.getDataSource(event.context));
      } else if (event is GetCountryByIdEvent) {
        yield GetCountrySuccess(await _countryService.getCountryById(event.id));
      } else if (event is GetCountryByCodeEvent) {
        yield GetCountrySuccess(
            await _countryService.getCountryByCode(event.code));
      } else {
        yield GetCountryFailed("No case");
      }
    } catch (e) {
      print("Error");
      print(e);
      yield GetCountryFailed(e);
    }
  }
}

// state
abstract class CountryState extends Equatable {
  const CountryState();

  @override
  List<Object> get props => [];
}

class CountryInitial extends CountryState {}

class GetCountryListSuccess extends CountryState {
  final List<LabelValue> addresses;
  GetCountryListSuccess(this.addresses);

  @override
  List<Object> get props => [addresses];
}

class GetCountrySuccess extends CountryState {
  final Country country;
  GetCountrySuccess(this.country);

  @override
  List<Object> get props => [country];
}

class GetCountryFailed extends CountryState {
  final String error;
  GetCountryFailed(this.error);

  @override
  List<Object> get props => [error];
}

// Event
abstract class CountryEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class GetCountryListEvent extends CountryEvent {
  final BuildContext context;
  GetCountryListEvent(this.context);

  @override
  List<Object> get props => [context];
}

class GetCountryByIdEvent extends CountryEvent {
  final int id;
  GetCountryByIdEvent(this.id);

  @override
  List<Object> get props => [id];
}

class GetCountryByCodeEvent extends CountryEvent {
  final String code;
  GetCountryByCodeEvent(this.code);

  @override
  List<Object> get props => [code];
}
