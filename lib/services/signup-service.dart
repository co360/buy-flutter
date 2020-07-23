import 'package:dio/dio.dart';
import 'package:storeFlutter/models/identity/signup-body.dart';
import 'package:storeFlutter/models/response-object.dart';
import 'package:storeFlutter/services/base-rest-service.dart';

class SignUpService extends BaseRestService {
  Future<ResponseMessage> registerBuyer(SignUpBody signUpBody) async {
    var url = 'store-identity-service/buyer/registerNew';
    final response = await dio.post(
      url,
      data: signUpBody.toJson(),
      options: Options(
          followRedirects: false,
          validateStatus: (status) {
            return status < 500;
          }),
    );
    
    ResponseObject<void> obj = response.data != null && response.data != "" ? ResponseObject<void>.fromJson(response.data) : null;
    if (obj != null && obj.messages != null && obj.messages.length > 0) {
      return obj.messages[0];
    } else {
      return null;
    }
  }
}




