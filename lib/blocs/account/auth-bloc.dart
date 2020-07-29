import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:storeFlutter/models/auth/login-body.dart';
import 'package:storeFlutter/models/auth/login-status.dart';
import 'package:storeFlutter/services/auth-service.dart';
import 'package:storeFlutter/services/initial-loading-service.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthService _authService = GetIt.I<AuthService>();
  final InitialLoadingService _initialLoadingService =
      GetIt.I<InitialLoadingService>();

  AuthBloc() : super(AuthInitial());

  @override
  Stream<AuthState> mapEventToState(AuthEvent event) async* {
    if (event is LoginEvent) {
      yield LoginInProgress();

      LoginStatus status = await _authService.loginUser(event.body);

      if (status.error != null) {
        yield LoginFailure(status.error);
        return;
      }

      // preload all necessary data
      await _initialLoadingService.reload();

      yield LoginSuccess();
    } else if (event is LogoutEvent) {
      _authService.logout();

      // need to relogin as guest

//      yield LogoutSuccess();
      add(LoginGuest());
      return;
    } else if (event is LoginGuest) {
      LoginStatus status = await _authService.loginAsGuest();

      if (status.error != null) {
        yield LoginFailure(status.error);
        return;
      }

      // preload all necessary data
      await _initialLoadingService.reload();

      yield LogoutSuccess();
    } else if (event is FlagLoginAsSuccess) {
      yield LoginSuccess();
    }
  }
}

// State
abstract class AuthState extends Equatable {
  @override
  List<Object> get props => [];
}

class AuthInitial extends AuthState {}

class LoginInProgress extends AuthState {}

class LoginSuccess extends AuthState {
//  final bool guest;
//
//  LoginSuccess(this.guest);
//
//  @override
//  List<Object> get props => [guest];
}

class LoginFailure extends AuthState {
  final String error;

  LoginFailure(this.error);

  @override
  List<Object> get props => [error];
}

class LogoutSuccess extends AuthState {}

// Event
abstract class AuthEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class LoginEvent extends AuthEvent {
  final BuildContext context;
  final LoginBody body;

  LoginEvent(this.body, this.context);

  @override
  List<Object> get props => [body, context];
}

class LogoutEvent extends AuthEvent {}

class LoginGuest extends AuthEvent {}

class FlagLoginAsSuccess extends AuthEvent {}
