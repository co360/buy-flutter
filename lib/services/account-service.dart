import 'package:storeFlutter/models/identity/account.dart';
import 'package:storeFlutter/services/base-rest-service.dart';

class AccountService extends BaseRestService {
  String _endPoint = 'store-identity-service/account';

  Future<Account> getAccountByUsername(String username) async {
    var url = '$_endPoint/username/$username';
    final response = await dio.get(url);

    return Account.fromJson(response.data);
  }
}
