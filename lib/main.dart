import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:flutter_i18n/loaders/decoders/json_decode_strategy.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get_it/get_it.dart';
import 'package:storeFlutter/blocs/account/auth-bloc.dart';
import 'package:storeFlutter/blocs/language/language-bloc.dart';
import 'package:storeFlutter/blocs/logging-bloc-observer.dart';
import 'package:storeFlutter/models/identity/account.dart';
import 'package:storeFlutter/screens/account.dart';
import 'package:storeFlutter/screens/account/login.dart';
import 'package:storeFlutter/screens/account/signup.dart';
import 'package:storeFlutter/screens/home.dart';
import 'package:storeFlutter/screens/main-layout.dart';
import 'package:storeFlutter/screens/orders.dart';
import 'package:storeFlutter/screens/shopping-cart.dart';
import 'package:storeFlutter/screens/shopping/product-detail.dart';
import 'package:storeFlutter/screens/shopping/product-listing.dart';
import 'package:storeFlutter/services/initial-loading-service.dart';
import 'package:storeFlutter/services/locator.dart';
import 'package:storeFlutter/services/storage-service.dart';
import 'package:storeFlutter/util/app-theme.dart';

// TODO to handle/test session scenario
// 1. [DONE] no token and login as guest
// 2. [DONE] got token but invalid/expired.. can renew and event set to LoginSuccess after renew
// 3. [DONE] got token but invalid/expired.. cannot renew and Login as guest.. set event as LogoutSuccess
// 4. [DONE] got token but invalid/expired... cannot renew and cannot login as guest.. set event as LoginFailed

// TODO ResponseUnwrapperInterceptor to parse massage automatically like angular
void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // TODO need to restructure the whole initialization and loading process
  await setupLocator();

  StorageService storageService = GetIt.I<StorageService>();

  SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(statusBarColor: Colors.transparent));

  // TODO session validation initailization should only start after runapp to prevent screen freeze
  print("is run here...");
  if (storageService.accessToken != null) {
    InitialLoadingService initialLoadingService =
        GetIt.I<InitialLoadingService>();
    await initialLoadingService.reload();

    // check if it's session still valid
    Account account = storageService.loginUser;

    if (account.userName != 'guest') {
      // manually set the AuthBloc state to LoginSuccess
      GetIt.I<AuthBloc>().add(FlagLoginAsSuccess());
    }
  } else {
    // login as guest
    AuthBloc authBloc = GetIt.I<AuthBloc>();
    authBloc.add(LoginGuest());
  }

  // TODO if cannot reload because no session or session expired.. need to login as guest..
  // TODO or do auto login as guest when we are in the DioLoggingInterceptors

  final FlutterI18nDelegate flutterI18nDelegate = FlutterI18nDelegate(
    translationLoader: FileTranslationLoader(
        decodeStrategies: [JsonDecodeStrategy()],
        useCountryCode: false,
        fallbackFile: 'en',
        forcedLocale: storageService.language != null
            ? Locale(storageService.language)
            : Locale('en')),
  );

  await flutterI18nDelegate.load(null);

  Bloc.observer = LoggingBlocObserver();

  runApp(MyApp(flutterI18nDelegate));
}

class MyApp extends StatelessWidget {
  final FlutterI18nDelegate flutterI18nDelegate;

  MyApp(this.flutterI18nDelegate);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    return FutureBuilder(
        future: GetIt.I.allReady(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            return MaterialApp(
              title: 'Flutter Demo',
              theme: ThemeData(
                primarySwatch:
                    Colors.grey, // use grey so the text title is black
                scaffoldBackgroundColor: AppTheme.colorBg2,
                appBarTheme: AppBarTheme(color: AppTheme.colorBg),
                visualDensity: VisualDensity.adaptivePlatformDensity,
              ),
              initialRoute: '/',
              routes: {
                '/': (context) => RootContainer(),
                '/product-listing': (context) => ProductListingScreen(),
                '/product-detail': (context) => ProductDetailScreen(),
                '/cart': (context) => ShoppingCartScreen(),
                '/login': (context) => LoginScreen(),
                '/signup': (context) => SignUpScreen()
              },
              localizationsDelegates: [
                flutterI18nDelegate,
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate
              ],
            );
          } else {
            return CircularProgressIndicator();
          }
        });
  }
}

class RootContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LanguageBloc, LanguageState>(
      bloc: GetIt.I<LanguageBloc>(),
      builder: (context, state) {
        List<Widget> allScreens = <Widget>[
          HomeScreen(),
          OrdersScreen(),
          ShoppingCartScreen(),
          AccountScreen()
        ];

        return MainLayout(allScreens);
      },
    );
  }
}
