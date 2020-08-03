import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:storeFlutter/datasource/city-data-source.dart';
import 'package:storeFlutter/models/label-value.dart';

// bloc
class CityBloc extends Bloc<CityEvent, CityState> {
  CityDataSource _cityDataSource = GetIt.I<CityDataSource>();

  CityBloc() : super(CityInitial());

  @override
  Stream<CityState> mapEventToState(CityEvent event) async* {
    try {
      if (event is GetCityListEvent) {
        yield GetCityListSuccess(await _cityDataSource
            .getDataSource(event.context, param: event.state));
      } else {
        yield GetCityFailed("No case");
      }
    } catch (e) {
      print("Error");
      print(e);
      yield GetCityFailed(e);
    }
  }
}

// state
abstract class CityState extends Equatable {
  const CityState();

  @override
  List<Object> get props => [];
}

class CityInitial extends CityState {}

class GetCityListSuccess extends CityState {
  final List<LabelValue> addresses;
  GetCityListSuccess(this.addresses);

  @override
  List<Object> get props => [addresses];
}

class GetCityFailed extends CityState {
  final String error;
  GetCityFailed(this.error);

  @override
  List<Object> get props => [error];
}

// Event
abstract class CityEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class GetCityListEvent extends CityEvent {
  final BuildContext context;
  final String state;
  GetCityListEvent(this.context, this.state);

  @override
  List<Object> get props => [context, state];
}
