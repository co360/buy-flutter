import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:storeFlutter/services/forget-password-service.dart';
import 'package:storeFlutter/models/identity/forget-password-body.dart';

// bloc
class ForgetPasswordBloc extends Bloc<ForgetPasswordEvent, ForgetPasswordState> {

  final ForgetPasswordService _accountService = GetIt.I<ForgetPasswordService>();

  ForgetPasswordBloc() : super(ForgetPasswordInitial());

  @override
  Stream<ForgetPasswordState> mapEventToState(ForgetPasswordEvent event) async* {
    if (event is LoadForgetPasswordEvent) {
      ForgetPasswordBody status = await _accountService.setForgetPassword(event.body);
      print(status);
      if(status != null) {
        yield ForgetPasswordSuccess();
      } else {
        yield ForgetPasswordFailed();
      }
    } else if (event is InitForgetPasswordEvent) {
      yield ForgetPasswordInitial();
    }
  }
}

// state
abstract class ForgetPasswordState extends Equatable {
  const ForgetPasswordState();

  @override
  List<Object> get props => [];
}

class ForgetPasswordInitial extends ForgetPasswordState {}

class ForgetPasswordSuccess extends ForgetPasswordState {}

class ForgetPasswordFailed extends ForgetPasswordState {}

// Event
abstract class ForgetPasswordEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class LoadForgetPasswordEvent extends ForgetPasswordEvent {
  final BuildContext context;
  final ForgetPasswordBody body;

  LoadForgetPasswordEvent(this.body, this.context);

  @override
  List<Object> get props => [body, context];
}

class InitForgetPasswordEvent extends ForgetPasswordEvent {}
