import 'package:storeFlutter/models/filter-type.dart';
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
    // TODO refactor to use search-param?
//    String searchParam = queryFilter.query;

    var url = '$_endPoint/searchCombinationB2C/';
    dynamic somedata = await dio
        .get<dynamic>(
      url,
      queryParameters: generateQueryParameter(queryFilter, page, pageSize),
//        queryParameters: {
//      "keyword": searchParam,
//      "_pageSize": pageSize,
//      "_page": page
//    }
    )
        .then((value) {
      print("Get something back from searchcombination");
      print(value);

      dynamic data = value.data;
      QueryResult<Product> result = QueryResult();
      result.page = page;
      result.pageSize = pageSize;

      if (value.data != null) {
        try {
          result.items = data['results']
              .map((e) => Product.fromJson(e))
              .toList()
              .cast<Product>();

          result.total = data['total'];

          // TODO parse filtered metas
          result.filterMetas = data['filterMetas']
              .map((e) => FilterMeta.fromJson(e))
              .toList()
              .cast<FilterMeta>();
        } catch (error, stacktrace) {
          print("catching error here first");
          print(error);
          print(stacktrace);

          // throw back
          throw error;
        }
      }

      return result;
    });

    return somedata;
  }

  Map<String, dynamic> generateQueryParameter(
      ProductListingQueryFilter filter, int page, int pageSize) {
    // TODO refactor to use search-param and FormUtil.generateQueryParameters?

    Map<String, dynamic> params = {
      "keyword": filter.query,
      "_pageSize": pageSize,
      "_page": page
    };

//    params
//        .addAll(filter.filters.map((key, value) => MapEntry(key, value.value)));

    params.addAll(filter.toQueryParameter());
    return params;
  }
}

class ProductListingQueryFilter {
  String query;

  Map<String, FilterValue> filters = {};

  ProductListingQueryFilter({this.query});

  ProductListingQueryFilter.copy(ProductListingQueryFilter filter) {
    query = filter.query;
    filters = Map.from(filter.filters);
  }

  toggleFilter(String filterCode, FilterValue value) {
    if (filters.containsKey(filterCode)) {
      filters.remove(filterCode);
    } else {
      filters[filterCode] = value;
    }
  }

  bool hasFilter(String filterCode, FilterValue value) {
    FilterValue val = filters[filterCode];

    if (val != null && val.value == value.value) return true;
    return false;
  }

  bool hasAnyFilter() {
    return filters.length > 0;
  }

  Map<String, String> toQueryParameter() {
    return filters.map((key, value) {
      String finalKey = key;

      if (key == 'CATEGORY') finalKey = "category.code";
      if (key == 'COUNTRY') finalKey = "sellerCountryCode";
      if (key == 'BUSINESS_TYPE') finalKey = "sellerBusinessTypes";

      return MapEntry(finalKey, value.value);
    });
  }
}
