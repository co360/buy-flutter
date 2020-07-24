import 'package:storeFlutter/models/identity/account.dart';
import 'package:storeFlutter/services/base-rest-service.dart';

class AccountService extends BaseRestService {
  String _endPoint = 'store-identity-service/account';

  Future<Account> getAccountByUsername(String username) async {
    var url = '$_endPoint/username/$username';
    final response = await dio.get(url);

    return Account.fromJson(response.data);
  }

  Future<Account> getAccountByID(int id) async {
    var url = '$_endPoint/$id';
    final response = await dio.get(url);

    return Account.fromJson(response.data['object']);
  }

  Future<Account> updateAccountByID(int id, Account account) async {
    var url = '$_endPoint/$id';
    final response = await dio.put(url, data: account.toJson());

    if (response.data['object'] != null) {
      return Account.fromJson(response.data['object']);
    } else {
      return null;
    }
  }
}
