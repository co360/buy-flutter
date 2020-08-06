import 'package:get_it/get_it.dart';
import 'package:storeFlutter/blocs/account/address-bloc.dart';
import 'package:storeFlutter/blocs/account/auth-bloc.dart';
import 'package:storeFlutter/blocs/account/signup-bloc.dart';
import 'package:storeFlutter/blocs/language/language-bloc.dart';
import 'package:storeFlutter/blocs/navigation/bottom-navigation-bloc.dart';
import 'package:storeFlutter/blocs/shopping/product-category-bloc.dart';
import 'package:storeFlutter/blocs/shopping/rating-bloc.dart';
import 'package:storeFlutter/blocs/shopping/sales-cart-bloc.dart';
import 'package:storeFlutter/blocs/shopping/shipment-bloc.dart';
import 'package:storeFlutter/datasource/annual-revenue-data-source.dart';
import 'package:storeFlutter/datasource/business-type-data-source.dart';
import 'package:storeFlutter/datasource/city-data-source.dart';
import 'package:storeFlutter/datasource/country-data-source.dart';
import 'package:storeFlutter/datasource/state-data-source.dart';
import 'package:storeFlutter/datasource/total-employee-data-source.dart';
import 'package:storeFlutter/services/account-service.dart';
import 'package:storeFlutter/services/auth-service.dart';
import 'package:storeFlutter/services/change-email-service.dart';
import 'package:storeFlutter/services/change-password-service.dart';
import 'package:storeFlutter/services/country-service.dart';
import 'package:storeFlutter/services/shipment-service.dart';
import 'package:storeFlutter/services/state-service.dart';
import 'package:storeFlutter/services/city-service.dart';
import 'package:storeFlutter/services/company-profile-service.dart';
import 'package:storeFlutter/services/company-service.dart';
import 'package:storeFlutter/services/consumer-product-list-price-service.dart';
import 'package:storeFlutter/services/forget-password-service.dart';
import 'package:storeFlutter/services/initial-loading-service.dart';
import 'package:storeFlutter/services/minimum-order-quantity-service.dart';
import 'package:storeFlutter/services/order-rate-review-service.dart';
import 'package:storeFlutter/services/product-category-service.dart';
import 'package:storeFlutter/services/product-service.dart';
import 'package:storeFlutter/services/product-stock-quantity-service.dart';
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
  GetIt.I.registerSingleton<ProductService>(ProductService());
  GetIt.I.registerSingleton<ProductCategoryService>(ProductCategoryService());
  GetIt.I.registerSingleton<ForgetPasswordService>(ForgetPasswordService());
  GetIt.I.registerSingleton<ChangePasswordService>(ChangePasswordService());
  GetIt.I.registerSingleton<ChangeEmailService>(ChangeEmailService());
  GetIt.I.registerSingleton<InitialLoadingService>(InitialLoadingService());
  GetIt.I.registerSingleton<SignUpService>(SignUpService());
  GetIt.I.registerSingleton<OrderRateReviewService>(OrderRateReviewService());
  GetIt.I.registerSingleton<SalesCartService>(SalesCartService());
  GetIt.I.registerSingleton<VariantTypeService>(VariantTypeService());
  GetIt.I.registerSingleton<CompanyService>(CompanyService());
  GetIt.I.registerSingleton<CompanyProfileService>(CompanyProfileService());
  GetIt.I.registerSingleton<CountryService>(CountryService());
  GetIt.I.registerSingleton<StateService>(StateService());
  GetIt.I.registerSingleton<CityService>(CityService());
  GetIt.I.registerSingleton<ShipmentService>(ShipmentService());

  GetIt.I.registerSingleton<MinimumOrderQuantityService>(
      MinimumOrderQuantityService());
  GetIt.I.registerSingleton<ProductStockQuantityService>(
      ProductStockQuantityService());
  GetIt.I.registerSingleton<ConsumerProductListPriceService>(
      ConsumerProductListPriceService());

  // Datasource
  GetIt.I.registerSingleton<BusinessTypeDataSource>(BusinessTypeDataSource());
  GetIt.I.registerSingleton<TotalEmployeeDataSource>(TotalEmployeeDataSource());
  GetIt.I.registerSingleton<AnnualRevenueDataSource>(AnnualRevenueDataSource());
  GetIt.I.registerSingleton<CountryDataSource>(CountryDataSource());
  GetIt.I.registerSingleton<StateDataSource>(StateDataSource());
  GetIt.I.registerSingleton<CityDataSource>(CityDataSource());

  // Bloc
  GetIt.I.registerSingleton<BottomNavigationBloc>(BottomNavigationBloc());
  GetIt.I.registerSingleton<LanguageBloc>(LanguageBloc());
  AuthBloc authBloc = AuthBloc();
  GetIt.I.registerSingleton<AuthBloc>(authBloc);
  GetIt.I.registerSingleton<SalesCartBloc>(SalesCartBloc(authBloc));

  // TODO remove singleton registration if bloc is only need to exist on certain screen
  GetIt.I.registerSingleton<AddressBloc>(AddressBloc());
  GetIt.I.registerSingleton<ProductCategoryBloc>(ProductCategoryBloc());
  GetIt.I.registerSingleton<SignUpBloc>(SignUpBloc());
  GetIt.I.registerSingleton<RatingBloc>(RatingBloc());
  GetIt.I.registerSingleton<ShipmentBloc>(ShipmentBloc());
}
