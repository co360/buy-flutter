import 'package:get_it/get_it.dart';
import 'package:storeFlutter/models/identity/account.dart';
import 'package:storeFlutter/models/shopping/sales-cart.dart';
import 'package:storeFlutter/models/shopping/sales-quotation.dart';
import 'package:storeFlutter/services/base-rest-service.dart';
import 'package:storeFlutter/services/storage-service.dart';

class SalesCartService extends BaseRestService {
  String _endPoint = 'store-shopping-service/salesCart';

  StorageService _storageService = GetIt.I<StorageService>();

  Future<SalesCart> refreshSalesCart() async {
    Account loginUser = _storageService.loginUser;

    if (loginUser != null) {
      return getSalesCart(loginUser.id);
    } else {
      return null;
    }
  }

  Future<SalesCart> getSalesCart(int accountId) async {
    var url = '$_endPoint/getSalesCart/$accountId';
    return await dio.get(url).then((value) {
      return getResponseObject<SalesCart>(
          value.data, (json) => SalesCart.fromJson(json));
    });
  }

  Future<SalesCart> addToCartB2C(int accountId, SalesQuotation cartDoc) async {
    var url = '$_endPoint/addToCartB2C/$accountId';
    return await dio.post(url, data: cartDoc.toJson()).then((value) {
      print("getting result here after addToCartB2C ${value.data['object']}");
      return getResponseObject<SalesCart>(
          value.data, (json) => SalesCart.fromJson(json));
    });
  }
}
