import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:storeFlutter/datasource/state-data-source.dart';
import 'package:storeFlutter/models/label-value.dart';

// bloc
class StateBloc extends Bloc<StateEvent, StateState> {
  StateDataSource _stateDataSource = GetIt.I<StateDataSource>();

  StateBloc() : super(StateInitial());

  @override
  Stream<StateState> mapEventToState(StateEvent event) async* {
    try {
      if (event is GetStateListEvent) {
        yield GetStateListInProgress();
        yield GetStateListSuccess(await _stateDataSource
            .getDataSource(event.context, param: event.country));
      } else if (event is GetStateFilter) {
        List<LabelValue> states = await _stateDataSource
            .getDataSource(event.context, param: event.country);
        RegExp exp = new RegExp(
          "${event.filter}",
          caseSensitive: false,
        );
        List<LabelValue> matchedItems = [];
        for (var f in states) {
          if (exp.hasMatch(f.label)) {
            matchedItems.add(f);
          }
        }
        yield GetStateListSuccess(matchedItems);
      } else {
        yield GetStateFailed("No case");
      }
    } catch (e) {
      print("Error");
      print(e);
      yield GetStateFailed(e);
    }
  }
}

// state
abstract class StateState extends Equatable {
  const StateState();

  @override
  List<Object> get props => [];
}

class StateInitial extends StateState {}

class GetStateListInProgress extends StateState {}

class GetStateListSuccess extends StateState {
  final List<LabelValue> addresses;
  GetStateListSuccess(this.addresses);

  @override
  List<Object> get props => [addresses];
}

class GetStateFailed extends StateState {
  final String error;
  GetStateFailed(this.error);

  @override
  List<Object> get props => [error];
}

// Event
abstract class StateEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class GetStateListEvent extends StateEvent {
  final BuildContext context;
  final String country;
  GetStateListEvent(this.context, this.country);

  @override
  List<Object> get props => [context, country];
}

class GetStateFilter extends StateEvent {
  final BuildContext context;
  final String filter;
  final String country;
  GetStateFilter(this.context, this.filter, this.country);

  @override
  List<Object> get props => [context, filter];
}
