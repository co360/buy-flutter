import 'package:storeFlutter/models/identity/company-profile.dart';
import 'package:storeFlutter/services/base-rest-service.dart';

class CompanyProfileService extends BaseRestService {
  String _endPoint = 'store-identity-service/company-profile';

  Future<CompanyProfile> findByCompany(int companyId) async {
    var url = '$_endPoint/find-by-company/$companyId';
    final response = await dio.get(url);

    return getResponseObject<CompanyProfile>(
        response.data, (json) => CompanyProfile.fromJson(json));
  }

  Future<CompanyProfile> updateCompanyProfile(
      CompanyProfile companyProfile) async {
    var url = '$_endPoint/${companyProfile.id}';
    final response = await dio.put(url, data: companyProfile.toJson());

    return getResponseObject<CompanyProfile>(
        response.data, (json) => CompanyProfile.fromJson(json));
  }
}
