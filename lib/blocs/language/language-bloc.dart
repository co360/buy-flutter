import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:get_it/get_it.dart';
import 'package:storeFlutter/components/app-notification.dart';
import 'package:storeFlutter/services/storage-service.dart';

// Because the the bloc is process simple so put all bloc, state and event into one file

// bloc
class LanguageBloc extends Bloc<LanguageEvent, LanguageState> {
  StorageService _storageService = GetIt.I<StorageService>();

  LanguageBloc() : super(LanguageInitial());

  @override
  Stream<LanguageState> mapEventToState(LanguageEvent event) async* {
    if (event is ChangeLanguage) {
      yield LanguageChangeInProgress();

      Locale currentLang = FlutterI18n.currentLocale(event.context);

      currentLang = Locale(event.languageCode);
      await FlutterI18n.refresh(event.context, currentLang);
      _storageService.language = event.languageCode;

      yield LanguageChangeSuccess();
      AppNotification(
        FlutterI18n.translate(
            event.context, "account.changeLanguageScreen.languageChanged"),
      ).show(event.context);
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

class LanguageChangeSuccess extends LanguageState {}

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
