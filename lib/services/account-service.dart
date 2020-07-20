import 'package:storeFlutter/models/identity/account.dart';
import 'package:storeFlutter/services/base-rest-service.dart';

class AccountService extends BaseRestService {
  static AccountService _instance;

  AccountService._();

  static AccountService getInstance() {
    if (_instance == null) {
      _instance = AccountService._();
    }

    return _instance;
  }

  Future<Account> getAccountByUsername(String username) async {
    var url = 'buy-identity-service/account/username/$username';
    final response = await dio.get(url);

    return Account.fromJson(response.data);
  }
}
