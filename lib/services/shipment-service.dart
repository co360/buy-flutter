import 'package:storeFlutter/models/shopping/easy-parcel-param.dart';
import 'package:storeFlutter/models/shopping/easy-parcel-response.dart';
import 'package:storeFlutter/services/base-rest-service.dart';

class ShipmentService extends BaseRestService {
  String _endPoint = 'store-shopping-service/extapi/shipment';

  Future<List<EasyParcelResponse>> getEasyParcel(EasyParcelParam params) async {
    var url = '$_endPoint/getprice';
    print("===============================");
    print(params.receiverPostcode);
    print(params.receiverState);
    print(params.receiverCountry);
    print("===============================");
    return await dio.post(url, data: params.toJson()).then((value) {
      print("[getEasyParcel] Response - $value");
      List<EasyParcelResponse> lists = [];
      if (value.data != null) {
        for (var f in value.data) {
          lists.add(EasyParcelResponse.fromJson(f));
        }
      }
      return lists;
    });
  }
}
