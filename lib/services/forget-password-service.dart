import 'package:storeFlutter/models/identity/forget-password-body.dart';
import 'package:storeFlutter/services/base-rest-service.dart';

class ForgetPasswordService extends BaseRestService {
  String url = 'store-identity-service/account/forgetPassword';

  Future<ForgetPasswordBody> setForgetPassword(
      ForgetPasswordBody forgetPasswordBody) async {
    final response = await dio.post(url, data: forgetPasswordBody.toJson());

    print(response.data);

    return getResponseObject<ForgetPasswordBody>(
        response.data, (json) => ForgetPasswordBody.fromJson(json));
  }
}
