import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// bloc
class SearchBloc extends Bloc<SearchEvent, SearchState> {
  SearchBloc() : super(SearchInitial());

  @override
  Stream<SearchState> mapEventToState(SearchEvent event) async* {
    if (event is SearchWithTerm) {
      yield SearchFinish(event.term);
    }
  }
}

// state
abstract class SearchState extends Equatable {
  @override
  List<Object> get props => [];
}

class SearchInitial extends SearchState {}

class SearchFinish extends SearchState {
  final String term;

  SearchFinish(this.term);

  @override
  List<Object> get props => [term];
}

// event

abstract class SearchEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class SearchWithTerm extends SearchEvent {
  final String term;

  SearchWithTerm(this.term);

  @override
  List<Object> get props => [term];
}
