import 'package:storeFlutter/models/identity/company-profile.dart';
import 'package:storeFlutter/models/shopping/product.dart';
import 'package:storeFlutter/services/base-rest-service.dart';

class SellerStoreService extends BaseRestService {
  String _compEndPoint = 'store-identity-service';
  String _ecommEndPoint = 'store-ecommerce-service';
  String _shopEndPoint = 'store-shopping-service';

  Future<List<Product>> getAllProducts(int companyId) async {
    var url =
        '$_ecommEndPoint/product/searchCombination/?companyId=$companyId&_page=0&_pageSize=100';
    return await dio.get(url).then((value) {
      print("[getAllProducts] Response - ${value.data['results']}");
      List<Product> lists = [];
      for (var f in value.data['results']) {
        lists.add(Product.fromJson(f));
      }
      return lists;
    });
  }

  Future<CompanyProfile> getCompanyProfile(int companyId) async {
    var url = '$_compEndPoint/company-profile/find-by-company/$companyId';
    return await dio.get(url).then((value) {
      print("[getCompanyProfile] Response - ${value.data['object']}");
      return CompanyProfile.fromJson(value.data['object']);
    });
  }

  Future<CompanyProfile> getReviews(int companyId) async {
    var url = '$_shopEndPoint/order-rate-review/byCompany/$companyId';
    return await dio.get(url).then((value) {
      print("[getCompanyProfile] Response - ${value.data['object']}");
      return CompanyProfile.fromJson(value.data['object']);
      ;
    });
  }
}
