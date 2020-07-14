import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:storeFlutter/components/app_notification.dart';

// Because the the bloc is process simple so put all bloc, state and event into one file

// bloc
class LanguageBloc extends Bloc<LanguageEvent, LanguageState> {
  @override
  LanguageState get initialState => LanguageInitial();

  @override
  Stream<LanguageState> mapEventToState(LanguageEvent event) async* {
    if (event is ChangeLanguage) {
      yield LanguageChangeInProgress();

      Locale currentLang = FlutterI18n.currentLocale(event.context);

      currentLang = Locale(event.languageCode);
      await FlutterI18n.refresh(event.context, currentLang);

      yield LanguageChangeSuccess();
//      final snackBar = SnackBar(content: Text('Yay! A SnackBar!'));
//      Scaffold.of(event.context).showSnackBar(snackBar);

//      Flushbar(
//        message: "Language Changed",
//        margin: EdgeInsets.only(left: 10, right: 10, bottom: 10),
//        borderRadius: 10,
//        animationDuration: Duration(
//          milliseconds: 500,
//        ),
//        duration: Duration(
//          seconds: 2,
//        ),
//      )..show(event.context);
      AppNotification("Language Change").show(event.context);
    } else if (event is SwitchLanguage) {
      yield LanguageChangeInProgress();

      Locale currentLang = FlutterI18n.currentLocale(event.context);

      currentLang =
          currentLang.languageCode == 'en' ? Locale('ms') : Locale('en');
      await FlutterI18n.refresh(event.context, currentLang);

      yield LanguageChangeSuccess();
    }
  }
}

// State
abstract class LanguageState extends Equatable {
  const LanguageState();

  @override
  List<Object> get props => [];
}

class LanguageInitial extends LanguageState {}

class LanguageChangeInProgress extends LanguageState {}

class LanguageChangeSuccess extends LanguageState {
  const LanguageChangeSuccess();
}

// Event
abstract class LanguageEvent extends Equatable {
  const LanguageEvent();

  @override
  List<Object> get props => [];
}

class ChangeLanguage extends LanguageEvent {
  final String languageCode;
  final BuildContext context;

  const ChangeLanguage(this.context, this.languageCode);

  @override
  List<Object> get props => [context, languageCode];
}

class SwitchLanguage extends LanguageEvent {
  final BuildContext context;

  const SwitchLanguage(this.context);

  @override
  List<Object> get props => [context];
}
