import 'package:storeFlutter/models/label-value.dart';
import 'package:storeFlutter/models/query-result.dart';
import 'package:storeFlutter/models/shopping/product.dart';
import 'package:storeFlutter/services/base-rest-service.dart';

class ProductService extends BaseRestService {
  // https://office.smarttradzt.com:8001/buy-ecommerce-service/product/searchCombination/?keyword=Flexible%20Packaging&category.code=FLEXIBLE_PACKAGING&_page=0&_pageSize=20

  String _endPoint = 'store-ecommerce-service/product';

  Future<List<LabelValue>> keyWordByName(String name) async {
    var url = '$_endPoint/keywordByName?name=$name';
    return await dio.get<List<dynamic>>(url).then((value) {
      print(value.data);

      return value.data.map((e) => LabelValue.fromJson(e)).toList();
    });
  }

  Future<QueryResult<Product>> searchProduct(
      ProductListingQueryFilter queryFilter,
      {int page = 0,
      int pageSize = 10}) async {
    String searchParam = queryFilter.query;

    var url = '$_endPoint/searchCombinationB2C/';
    dynamic somedata = await dio.get<dynamic>(url, queryParameters: {
      "keyword": searchParam,
      "_pageSize": pageSize,
      "_page": page
    }).then((value) {
      print("Get something back from searchcombination");
      print(value);

      dynamic data = value.data;
      QueryResult<Product> result = QueryResult();
      result.page = page;
      result.pageSize = pageSize;

      if (value.data != null) {
//        try {
        result.items = data['results']
            .map((e) => Product.fromJson(e))
            .toList()
            .cast<Product>();

        result.total = data['total'];
//        } catch (error, stacktrace) {
//          print("catching error here first");
//          print(error);
//          print(stacktrace);
//
//          // throw back
//          throw error;
//        }
      }

      // TODO parse filtered metas

      return result;
    });

    return somedata;
  }
}

class ProductListingQueryFilter {
  String query;

  // TODO include filtering criteria

  ProductListingQueryFilter({this.query});
}
