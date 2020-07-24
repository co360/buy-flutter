import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:storeFlutter/services/account-service.dart';
import 'package:storeFlutter/models/identity/account.dart';
import 'package:storeFlutter/services/initial-loading-service.dart';

// bloc
class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final AccountService _accountService = GetIt.I<AccountService>();

  ProfileBloc() : super(ProfileInitial());

  @override
  Stream<ProfileState> mapEventToState(ProfileEvent event) async* {
    yield ProfileInProgress();

    if (event is LoadProfileEvent) {
      Account status = await _accountService.getAccountByID(event.id);
      if (status != null) {
        yield ProfileSuccess(status);
      } else {
        yield ProfileFailed();
      }
    } else if (event is InitProfileEvent) {
      yield ProfileInitial();
    } else if (event is SaveProfileEvent) {
      Account status =
          await _accountService.updateAccountByID(event.id, event.account);
      if (status != null) {
        InitialLoadingService initialLoadingService =
            GetIt.I<InitialLoadingService>();
        await initialLoadingService.reload();

        yield ProfileSuccess(status);
      } else {
        yield ProfileFailed();
      }
    }
  }
}

// state
abstract class ProfileState extends Equatable {
  const ProfileState();

  @override
  List<Object> get props => [];
}

class ProfileInitial extends ProfileState {}

class ProfileSuccess extends ProfileState {
  final Account account;

  ProfileSuccess(this.account);

  @override
  List<Object> get props => [account];
}

class ProfileInProgress extends ProfileState {}

class ProfileFailed extends ProfileState {}

// Event
abstract class ProfileEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class LoadProfileEvent extends ProfileEvent {
  final int id;

  LoadProfileEvent(this.id);

  @override
  List<Object> get props => [id];
}

class SaveProfileEvent extends ProfileEvent {
  final Account account;
  final int id;

  SaveProfileEvent(this.id, this.account);

  @override
  List<Object> get props => [id, account];
}

class InitProfileEvent extends ProfileEvent {}
