import 'package:storeFlutter/models/identity/company.dart';
import 'package:storeFlutter/services/base-rest-service.dart';

class CompanyService extends BaseRestService {
  String _endPoint = 'store-identity-service/company';

  Future<Company> getCompany(int id) async {
    var url = '$_endPoint/$id';
    final response = await dio.get(url);

    return Company.fromJson(response.data['object']);
  }
}
