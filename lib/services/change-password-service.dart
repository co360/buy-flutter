import 'package:storeFlutter/models/identity/change-password-body.dart';
import 'package:storeFlutter/services/base-rest-service.dart';

class ChangePasswordService extends BaseRestService {
  String _endPoint = 'store-identity-service/account';

  Future<ChangePasswordBody> changePassword(
      String username, ChangePasswordBody data) async {
    var url = '$_endPoint/update-password/$username';
    try {
      final response = await dio.put(url, data: data.toJson());
      print(response.data);

      return getResponseObject<ChangePasswordBody>(
          response.data, (json) => ChangePasswordBody.fromJson(json));
    } catch (e) {
      return null;
    }
  }
}
