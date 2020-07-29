import 'package:get_it/get_it.dart';
import 'package:storeFlutter/models/auth/current-user.dart';
import 'package:storeFlutter/models/identity/account.dart';
import 'package:storeFlutter/services/account-service.dart';
import 'package:storeFlutter/services/address-service.dart';
import 'package:storeFlutter/services/auth-service.dart';
import 'package:storeFlutter/services/base-rest-service.dart';
import 'package:storeFlutter/services/storage-service.dart';

class InitialLoadingService extends BaseRestService {
  AccountService _accountService = GetIt.I<AccountService>();
  AuthService _authService = GetIt.I<AuthService>();
  StorageService _storageService = GetIt.I<StorageService>();
  AddressService _addressService = GetIt.I<AddressService>();

//  load(String username) async {
//    Account account = await _accountService.getAccountByUsername(username);
//
//    _storageService.loginUser = account;
//  }

  reload() async {
    // should load all.. including for guest...
    CurrentUser currentUser = await _authService.currentUser();

    Account account =
        await _accountService.getAccountByUsername(currentUser.username);

    _storageService.loginUser = account;

    preCacheData();

    // TODO load shopping cart item to display number of itme in the cart
  }

  preCacheData() async {
    if(_storageService.countries == null || _storageService.countries.length <= 0){
      _storageService.countries = await _addressService.getCountryList();
    }
  }
}
