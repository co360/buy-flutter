import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:flutter_i18n/loaders/decoders/json_decode_strategy.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get_it/get_it.dart';
import 'package:storeFlutter/blocs/language/language_bloc.dart';
import 'package:storeFlutter/screens/account.dart';
import 'package:storeFlutter/screens/home.dart';
import 'package:storeFlutter/screens/main_layout.dart';
import 'package:storeFlutter/screens/orders.dart';
import 'package:storeFlutter/screens/shopping/product_detail.dart';
import 'package:storeFlutter/screens/shopping/product_listing.dart';
import 'package:storeFlutter/screens/shopping_cart.dart';
import 'package:storeFlutter/services/locator.dart';
import 'package:storeFlutter/util/app-theme.dart';

void main() async {
  final FlutterI18nDelegate flutterI18nDelegate = FlutterI18nDelegate(
    translationLoader: FileTranslationLoader(
        decodeStrategies: [JsonDecodeStrategy()],
        useCountryCode: false,
        fallbackFile: 'en',
        forcedLocale: Locale('en')),
  );
  WidgetsFlutterBinding.ensureInitialized();

  await flutterI18nDelegate.load(null);
  setupLocator();
  runApp(MyApp(flutterI18nDelegate));
}

class MyApp extends StatelessWidget {
  final FlutterI18nDelegate flutterI18nDelegate;

  MyApp(this.flutterI18nDelegate);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
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
                '/listing': (context) => ProductListingScreen(),
                '/detail': (context) => ProductDetailScreen(),
                '/cart': (context) => ShoppingCartScreen(),
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

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class RootContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LanguageBloc, LanguageState>(
      bloc: GetIt.I<LanguageBloc>(),
//          bloc: LanguageBloc(context),
      builder: (context, state) {
        print('change laguage $state');
        print(FlutterI18n.currentLocale(context));

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

class _MyHomePageState extends State<MyHomePage> {
//  Locale currentLang;
  int _counter = 0;

//  @override
//  void initState() {
//    super.initState();
//    Future.delayed(Duration.zero, () async {
//      setState(() {
//        currentLang = FlutterI18n.currentLocale(context);
//      });
//    });
//  }

//  changeLanguage() async {
//    currentLang =
//        currentLang.languageCode == 'en' ? Locale('ms') : Locale('en');
//    await FlutterI18n.refresh(context, currentLang);
//    setState(() {});
//  }

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LanguageBloc, LanguageState>(
      bloc: GetIt.I<LanguageBloc>(),
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: I18nText(
              "label.main",
              translationParams: {"user": "Yoke Harn"},
            ),
          ),
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                I18nText("shopping.productDetail.productInformation"),
                RaisedButton(
                  key: Key('changeLanguage'),
                  onPressed: () async {
                    GetIt.I<LanguageBloc>().add(SwitchLanguage(context));
//                    await GetIt.I<LanguageUtil>().switchLanguage(context);
//                    setState(() {});
//                    Scaffold.of(context).showSnackBar(SnackBar(
//                      content: Text(FlutterI18n.translate(
//                          context, "button.toastMessage")),
//                    ));
                  },
//              onPressed: () async {
//                await changeLanguage();
//                Scaffold.of(context).showSnackBar(SnackBar(
//                  content: Text(
//                      FlutterI18n.translate(context, "button.toastMessage")),
//                ));
//              },
                  child: Text(
                    FlutterI18n.translate(context, "button.label.language"),
                  ),
                ),
                Text(
                  'You have pushed the button this many times:',
                ),
                Text(
                  '$_counter',
                  style: Theme.of(context).textTheme.headline4,
                ),
              ],
            ),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: _incrementCounter,
            tooltip: 'Increment',
            child: Icon(Icons.add),
          ),
        );
      },
    );
  }
}
