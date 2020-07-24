import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:storeFlutter/services/change-password-service.dart';
import 'package:storeFlutter/models/identity/change-password-body.dart';

// bloc
class ChangePasswordBloc
    extends Bloc<ChangePasswordEvent, ChangePasswordState> {
  final ChangePasswordService _changePasswordService =
      GetIt.I<ChangePasswordService>();

  ChangePasswordBloc() : super(ChangePasswordInitial());

  @override
  Stream<ChangePasswordState> mapEventToState(
      ChangePasswordEvent event) async* {
    yield ChangePasswordInProgress();
    if (event is SaveChangePasswordEvent) {
      ChangePasswordBody status = await _changePasswordService.changePassword(
          event.username, event.body);
      print("ChangePasswordBloc");
      print(status);
      if (status != null) {
        yield ChangePasswordSuccess();
      } else {
        yield ChangePasswordFailed();
      }
    } else if (event is InitChangePasswordEvent) {
      yield ChangePasswordInitial();
    }
  }
}

// state
abstract class ChangePasswordState extends Equatable {
  const ChangePasswordState();

  @override
  List<Object> get props => [];
}

class ChangePasswordInitial extends ChangePasswordState {}

class ChangePasswordInProgress extends ChangePasswordState {}

class ChangePasswordSuccess extends ChangePasswordState {}

class ChangePasswordFailed extends ChangePasswordState {}

// Event
abstract class ChangePasswordEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class SaveChangePasswordEvent extends ChangePasswordEvent {
  final BuildContext context;
  final String username;
  final ChangePasswordBody body;

  SaveChangePasswordEvent(this.username, this.body, this.context);

  @override
  List<Object> get props => [username, body, context];
}

class InitChangePasswordEvent extends ChangePasswordEvent {}
