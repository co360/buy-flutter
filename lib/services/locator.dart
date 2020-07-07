import 'package:get_it/get_it.dart';
import 'package:storeFlutter/blocs/language/language_bloc.dart';

void setupLocator() {
//  GetIt.I.registerSingleton<LanguageUtil>(LanguageUtil());
  GetIt.I.registerSingleton<LanguageBloc>(LanguageBloc());
}
