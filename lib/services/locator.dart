import 'package:get_it/get_it.dart';
import 'package:storeFlutter/blocs/account/auth-bloc.dart';
import 'package:storeFlutter/blocs/account/forget-password-bloc.dart';
import 'package:storeFlutter/blocs/shopping/product-category-bloc.dart';
import 'package:storeFlutter/blocs/language/language-bloc.dart';
import 'package:storeFlutter/services/account-service.dart';
import 'package:storeFlutter/services/auth-service.dart';
import 'package:storeFlutter/services/forget-password-service.dart';
import 'package:storeFlutter/services/initial-loading-service.dart';
import 'package:storeFlutter/services/product-service.dart';
import 'package:storeFlutter/services/product-category-service.dart';
import 'package:storeFlutter/services/storage-service.dart';

Future setupLocator() async {
  // Service
  StorageService sharedPreferencesService = await StorageService.getInstance();
  GetIt.I.registerSingleton<StorageService>(sharedPreferencesService);

  GetIt.I.registerSingleton<AccountService>(AccountService());
  GetIt.I.registerSingleton<AuthService>(AuthService());
  GetIt.I.registerSingleton<ProductService>(ProductService());
  GetIt.I.registerSingleton<ProductCategoryService>(ProductCategoryService());
  GetIt.I.registerSingleton<ForgetPasswordService>(ForgetPasswordService());
  GetIt.I.registerSingleton<InitialLoadingService>(InitialLoadingService());

  // Bloc
  GetIt.I.registerSingleton<LanguageBloc>(LanguageBloc());
  GetIt.I.registerSingleton<AuthBloc>(AuthBloc());
  GetIt.I.registerSingleton<ForgetPasswordBloc>(ForgetPasswordBloc());
  GetIt.I.registerSingleton<ProductCategoryBloc>(ProductCategoryBloc());
}
