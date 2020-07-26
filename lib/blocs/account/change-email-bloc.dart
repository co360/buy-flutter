import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:storeFlutter/services/change-email-service.dart';
import 'package:storeFlutter/models/identity/change-email-body.dart';

// bloc
class ChangeEmailBloc extends Bloc<ChangeEmailEvent, ChangeEmailState> {
  final ChangeEmailService _changeEmailService = GetIt.I<ChangeEmailService>();

  ChangeEmailBloc() : super(ChangeEmailInitial());

  @override
  Stream<ChangeEmailState> mapEventToState(ChangeEmailEvent event) async* {
    // yield ChangeEmailInProgress();
    if (event is SendChangeEmailEvent) {
      bool status = await _changeEmailService.changeEmail(event.body);
      print(status);
      if (status) {
        yield ChangeEmailSuccess(event.body.newEmail);
      } else {
        yield ChangeEmailFailed();
      }
    } else if (event is SendConfirmCodeEvent) {
      bool status = await _changeEmailService.sendConfirmCode(event.body);
      print(status);
      if (status) {
        yield ConfirmCodeSuccess(event.body.newEmail);
      } else {
        yield ConfirmCodeFailed();
      }
    } else if (event is InitChangeEmailEvent) {
      yield ChangeEmailInitial();
    }
  }
}

// state
abstract class ChangeEmailState extends Equatable {
  const ChangeEmailState();

  @override
  List<Object> get props => [];
}

class ChangeEmailInitial extends ChangeEmailState {}

class ChangeEmailInProgress extends ChangeEmailState {}

class ChangeEmailSuccess extends ChangeEmailState {
  final String email;

  ChangeEmailSuccess(this.email);

  @override
  List<Object> get props => [email];
}

class ChangeEmailFailed extends ChangeEmailState {}

class ConfirmCodeSuccess extends ChangeEmailState {
  final String email;

  ConfirmCodeSuccess(this.email);

  @override
  List<Object> get props => [email];
}

class ConfirmCodeFailed extends ChangeEmailState {}

// Event
abstract class ChangeEmailEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class SendChangeEmailEvent extends ChangeEmailEvent {
  final BuildContext context;
  final ChangeEmailBody body;

  SendChangeEmailEvent(this.body, this.context);

  @override
  List<Object> get props => [body, context];
}

class SendConfirmCodeEvent extends ChangeEmailEvent {
  final BuildContext context;
  final ChangeEmailBody body;

  SendConfirmCodeEvent(this.body, this.context);

  @override
  List<Object> get props => [body, context];
}

class InitChangeEmailEvent extends ChangeEmailEvent {}
