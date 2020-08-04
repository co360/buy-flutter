import 'package:storeFlutter/models/shopping/order-rate-review.dart';
import 'package:storeFlutter/services/base-rest-service.dart';

class OrderRateReviewService extends BaseRestService {
  String _endPoint = 'store-shopping-service/order-rate-review';

  Future<List<OrderRateReview>> getByCompanyId(int companyId) async {
    var url = '$_endPoint/byCompany/$companyId';
    // var url = '$_endPoint/202001080000018';
    return await dio.get(url).then((value) {
      print("[getByCompanyId] Response - ${value.data['object']}");
      List<OrderRateReview> lists = [];
      if (value.data['object'] != null) {
        for (var f in value.data['object']) {
          lists.add(OrderRateReview.fromJson(f));
        }
      }
      return lists;
    });
  }

  Future<List<OrderRateReview>> getByProductId(int productId) async {
    var url = '$_endPoint/byProduct/$productId';
    // var url = '$_endPoint/byProduct/202002100000019';
    return await dio.get(url).then((value) {
      print("[getByProductId] Response - ${value.data['object']}");
      List<OrderRateReview> lists = [];
      if (value.data['object'] != null) {
        for (var f in value.data['object']) {
          lists.add(OrderRateReview.fromJson(f));
        }
      }
      return lists;
    });
  }

  Future<List<OrderRateReview>> getBySalesOrderId(int productId) async {
    var url = '$_endPoint/bySalesOrder/$productId';
    // var url = '$_endPoint/202001080000018';
    return await dio.get(url).then((value) {
      print("[getBySalesOrderId] Response - ${value.data['object']}");
      List<OrderRateReview> lists = [];
      if (value.data['object'] != null) {
        for (var f in value.data['object']) {
          lists.add(OrderRateReview.fromJson(f));
        }
      }
      return lists;
    });
  }
}
