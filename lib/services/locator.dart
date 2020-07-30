import 'package:get_it/get_it.dart';
import 'package:storeFlutter/blocs/account/auth-bloc.dart';
import 'package:storeFlutter/blocs/account/address-bloc.dart';
import 'package:storeFlutter/blocs/account/change-email-bloc.dart';
import 'package:storeFlutter/blocs/account/change-password-bloc.dart';
import 'package:storeFlutter/blocs/account/forget-password-bloc.dart';
import 'package:storeFlutter/blocs/account/profile-bloc.dart';
import 'package:storeFlutter/blocs/account/signup-bloc.dart';
import 'package:storeFlutter/blocs/language/language-bloc.dart';
import 'package:storeFlutter/blocs/navigation/bottom-navigation-bloc.dart';
import 'package:storeFlutter/blocs/shopping/product-category-bloc.dart';
import 'package:storeFlutter/blocs/shopping/sales-cart-bloc.dart';
import 'package:storeFlutter/blocs/shopping/rating-bloc.dart';
import 'package:storeFlutter/services/account-service.dart';
import 'package:storeFlutter/services/auth-service.dart';
import 'package:storeFlutter/services/address-service.dart';
import 'package:storeFlutter/services/change-email-service.dart';
import 'package:storeFlutter/services/change-password-service.dart';
import 'package:storeFlutter/services/forget-password-service.dart';
import 'package:storeFlutter/services/initial-loading-service.dart';
import 'package:storeFlutter/services/product-category-service.dart';
import 'package:storeFlutter/services/product-service.dart';
import 'package:storeFlutter/services/rating-service.dart';
import 'package:storeFlutter/services/sales-cart-service.dart';
import 'package:storeFlutter/services/signup-service.dart';
import 'package:storeFlutter/services/storage-service.dart';
import 'package:storeFlutter/services/variant-type-service.dart';

Future setupLocator() async {
  // Service
  StorageService sharedPreferencesService = await StorageService.getInstance();
  GetIt.I.registerSingleton<StorageService>(sharedPreferencesService);

  GetIt.I.registerSingleton<AccountService>(AccountService());
  GetIt.I.registerSingleton<AuthService>(AuthService());
  GetIt.I.registerSingleton<AddressService>(AddressService());
  GetIt.I.registerSingleton<ProductService>(ProductService());
  GetIt.I.registerSingleton<ProductCategoryService>(ProductCategoryService());
  GetIt.I.registerSingleton<ForgetPasswordService>(ForgetPasswordService());
  GetIt.I.registerSingleton<ChangePasswordService>(ChangePasswordService());
  GetIt.I.registerSingleton<ChangeEmailService>(ChangeEmailService());
  GetIt.I.registerSingleton<InitialLoadingService>(InitialLoadingService());
  GetIt.I.registerSingleton<SignUpService>(SignUpService());
  GetIt.I.registerSingleton<RatingService>(RatingService());
  GetIt.I.registerSingleton<SalesCartService>(SalesCartService());
  GetIt.I.registerSingleton<VariantTypeService>(VariantTypeService());

  // Bloc
  GetIt.I.registerSingleton<BottomNavigationBloc>(BottomNavigationBloc());
  GetIt.I.registerSingleton<LanguageBloc>(LanguageBloc());
  AuthBloc authBloc = AuthBloc();
  GetIt.I.registerSingleton<AuthBloc>(authBloc);
  GetIt.I.registerSingleton<SalesCartBloc>(SalesCartBloc(authBloc));

  // TODO remove singleton registration if bloc is only need to exist on certain screen
  GetIt.I.registerSingleton<ProfileBloc>(ProfileBloc());
  GetIt.I.registerSingleton<AddressBloc>(AddressBloc());
  GetIt.I.registerSingleton<ForgetPasswordBloc>(ForgetPasswordBloc());
  GetIt.I.registerSingleton<ChangePasswordBloc>(ChangePasswordBloc());
  GetIt.I.registerSingleton<ChangeEmailBloc>(ChangeEmailBloc());
  GetIt.I.registerSingleton<ProductCategoryBloc>(ProductCategoryBloc());
  GetIt.I.registerSingleton<SignUpBloc>(SignUpBloc());
  GetIt.I.registerSingleton<RatingBloc>(RatingBloc());
}
