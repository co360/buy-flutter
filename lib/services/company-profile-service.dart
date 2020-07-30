import 'package:storeFlutter/models/identity/company-profile.dart';
import 'package:storeFlutter/services/base-rest-service.dart';

class CompanyProfileService extends BaseRestService {
  String _endPoint = 'store-identity-service/company-profile';

  Future<CompanyProfile> findByCompany(int companyId) async {
    var url = '$_endPoint/find-by-company/$companyId';
    final response = await dio.get(url);

    return CompanyProfile.fromJson(response.data['object']);
  }
}
