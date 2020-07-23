import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:storeFlutter/models/identity/signup-body.dart';
import 'package:storeFlutter/models/response-object.dart';
import 'package:storeFlutter/services/signup-service.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  final SignUpService _authService = GetIt.I<SignUpService>();

  SignUpBloc() : super(SignUpInitial());

  @override
  Stream<SignUpState> mapEventToState(SignUpEvent event) async* {
    if (event is RegisterEvent) {
      yield SignUpInProgress();

      ResponseMessage msg = await _authService.registerBuyer(event.body);

      if(msg != null && msg.type == "ERROR") {
        yield SignUpFailure(msg.message);
      } else {
        yield SignUpSuccess();
      }
    } else if (event is InitSignUpEvent) {
      yield SignUpInitial();
    }
  }
}

// State
abstract class SignUpState extends Equatable {
  @override
  List<Object> get props => [];
}

class SignUpInitial extends SignUpState {}

class SignUpInProgress extends SignUpState {}

class LoadSignUp extends SignUpState {}

class SignUpSuccess extends SignUpState {
//  final bool guest;
//
//  SignUpSuccess(this.guest);
//
//  @override
//  List<Object> get props => [guest];
}

class SignUpFailure extends SignUpState {
  final String error;

  SignUpFailure(this.error);

  @override
  List<Object> get props => [error];
}

// Event
abstract class SignUpEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class InitSignUpEvent extends SignUpEvent {}

class RegisterEvent extends SignUpEvent {
  final BuildContext context;
  final SignUpBody body;

  RegisterEvent(this.body, this.context);

  @override
  List<Object> get props => [body, context];
}

//class LogoutEvent extends SignUpEvent {}
//
//class SignUpGuest extends SignUpEvent {}
