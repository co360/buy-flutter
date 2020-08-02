import 'package:storeFlutter/models/shopping/order-rate-review.dart';
import 'package:storeFlutter/services/base-rest-service.dart';

class RatingService extends BaseRestService {
  String _endPoint = 'store-shopping-service/order-rate-review/byCompany';

  Future<List<OrderRateReview>> getAllRatingsByID(int companyId) async {
    var url = '$_endPoint/$companyId';
    // var url = '$_endPoint/202001080000018';
    return await dio.get(url).then((value) {
      print("[getAllRatingsByID] Response - ${value.data['object']}");
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
