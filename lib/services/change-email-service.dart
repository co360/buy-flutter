import 'package:storeFlutter/models/identity/change-email-body.dart';
import 'package:storeFlutter/services/base-rest-service.dart';

class ChangeEmailService extends BaseRestService {
  String _endPoint = 'store-identity-service/account';

  Future<bool> changeEmail(ChangeEmailBody data) async {
    var url = '$_endPoint/changeEmail';
    try {
      // Data
      // email: "ammar.abdullah@smarttradzt.com"
      // newEmail: "ammar.abdullah@acceval-intl.com"
      final response = await dio.post(url, data: data.toJson());
      print(response.data);
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> sendConfirmCode(ChangeEmailBody data) async {
    var url = '$_endPoint/confirmCode';
    try {
      // Data
      // email: "ammar.abdullah@smarttradzt.com"
      // newEmail: "ammar.abdullah@acceval-intl.com"
      // verificationCode: "685569"
      final response = await dio.post(url, data: data.toJson());
      print(response.data);
      return true;
    } catch (e) {
      return false;
    }
  }
}
