import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// bloc
class AccountBloc extends Bloc<AccountEvent, AccountState> {
  AccountBloc() : super(AcocuntInitial());

  @override
  Stream<AccountState> mapEventToState(AccountEvent event) {
    if (event is LoadAccount) {}
  }
}

// state
abstract class AccountState extends Equatable {
  const AccountState();

  @override
  List<Object> get props => [];
}

class AcocuntInitial extends AccountState {}

class AcocuntLoadingInProgress extends AccountState {}

class AcocuntLoadingFailed extends AccountState {}

class AcocuntLoadingSuccess extends AccountState {}

// Event
abstract class AccountEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class LoadAccount extends AccountEvent {}
