import 'package:dio/dio.dart';
import 'package:storeFlutter/models/identity/forget-password-body.dart';
import 'package:storeFlutter/services/base-rest-service.dart';

class ForgetPasswordService extends BaseRestService {

  Future<ForgetPasswordBody> setForgetPassword(ForgetPasswordBody forgetPasswordBody) async {
    var url = 'buy-identity-service/account/forgetPassword';
    final response = await dio.post(
      url,
      data: forgetPasswordBody.toJson()
    );

    print(response.data);

    if(response.data['object'] != null) {
      return ForgetPasswordBody.fromJson(response.data['object']);
    } else {
      return null;
    }
  }
}
