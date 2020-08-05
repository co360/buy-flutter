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

    return getResponseObject<Account>(
        response.data, (json) => Account.fromJson(json));
  }

  Future<Account> updateAccountByID(int id, Account account) async {
    var url = '$_endPoint/$id';
    final response = await dio.put(url, data: account.toJson());

    return getResponseObject<Account>(
        response.data, (json) => Account.fromJson(json));
  }
}
