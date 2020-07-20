import 'package:get_it/get_it.dart';
import 'package:storeFlutter/blocs/account/auth-bloc.dart';
import 'package:storeFlutter/blocs/language/language-bloc.dart';
import 'package:storeFlutter/services/auth-service.dart';
import 'package:storeFlutter/services/initial-loading-service.dart';
import 'package:storeFlutter/services/storage-service.dart';

Future setupLocator() async {
  // Service
  StorageService sharedPreferencesService = await StorageService.getInstance();
  GetIt.I.registerSingleton<StorageService>(sharedPreferencesService);

//  GetIt.I.registerSingleton<AccountService>(AccountService());
  GetIt.I.registerSingleton<AuthService>(AuthService());
  GetIt.I.registerSingleton<InitialLoadingService>(InitialLoadingService());

  // Bloc
  GetIt.I.registerSingleton<LanguageBloc>(LanguageBloc());
  GetIt.I.registerSingleton<AuthBloc>(AuthBloc());
}
