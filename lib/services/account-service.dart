import 'package:storeFlutter/models/identity/account.dart';
import 'package:storeFlutter/services/base-rest-service.dart';

class AccountService extends BaseRestService {
  Future<Account> getAccountByUsername(String username) async {
    var url = 'buy-identity-service/account/username/$username';
    final response = await dio.get(url);

    return Account.fromJson(response.data);
  }
}
