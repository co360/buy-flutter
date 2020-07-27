import 'package:storeFlutter/models/shopping/category.dart';
import 'package:storeFlutter/models/query-result-category.dart';
import 'package:storeFlutter/services/base-rest-service.dart';

class ProductCategoryService extends BaseRestService {
  String url = 'store-ecommerce-service/category/find-all';
  List fullList = [];

  Future<QueryResultCategory> loadProductCategory(int activeId) async {
    final response = await dio.get(url);

    if (response.data['object'] != null) {
      fullList = response.data['object'];

      if (fullList.length == 0) return null;

      return searchOp(activeId);
    } else {
      return null;
    }
  }

  Future<QueryResultCategory> switchProductCategory(int activeId) async {
    if (fullList != null && fullList.length > 0) {
      return searchOp(activeId);
    } else {
      return null;
    }
  }

  Future<QueryResultCategory> searchOp(int activeId) async {
    List<int> categoryIdsList = [];
    List<Layer1CategoryLists> layer1Categories = [];
    List<Layer2CategoryLists> layer2Categories = [];

    // Find layer 1 category
    for (var f in fullList) {
      var data = Category.fromJson(f);
      if (data.parentCategory != null &&
          data.parentCategory.parentCategory == null &&
          !categoryIdsList.contains(data.parentCategory.id)) {
        if (activeId == 0) activeId = data.parentCategory.id;
        categoryIdsList.add(data.parentCategory.id);
        layer1Categories.add(Layer1CategoryLists(
            data.parentCategory.id,
            data.parentCategory.name,
            data.parentCategory.id == activeId ? true : false));
      }
    }

    for (var f in fullList) {
      var data = Category.fromJson(f);

      // Find layer 2 category
      if (data.parentCategory != null && data.parentCategory.id == activeId) {
        // Add itself to the 3rd layer
        List<Layer3CategoryLists> layer3Category = [];
        layer3Category.add(Layer3CategoryLists(data.id, data.name));
        layer2Categories
            .add(Layer2CategoryLists(data.id, data.name, layer3Category));
      }
    }

    for (var f in fullList) {
      var data = Category.fromJson(f);

      // Find layer 3 category
      if (data.parentCategory != null &&
          data.parentCategory.parentCategory != null &&
          data.parentCategory.parentCategory.id == activeId) {
        for (var c in layer2Categories) {
          if (c.id == data.parentCategory.id) {
            c.layer3Category.add(Layer3CategoryLists(data.id, data.name));
            break;
          }
        }
      }
    }

    for (var f in fullList) {
      var data = Category.fromJson(f);

      // Find layer 4 category
      if (data.parentCategory != null &&
          data.parentCategory.parentCategory != null &&
          data.parentCategory.parentCategory.parentCategory != null &&
          data.parentCategory.parentCategory.parentCategory.id == activeId) {
        for (var c in layer2Categories) {
          if (c.id == data.parentCategory.parentCategory.id) {
            c.layer3Category.add(Layer3CategoryLists(data.id, data.name));
            break;
          }
        }
      }
    }

    QueryResultCategory result = QueryResultCategory();
    result.layer1Category = layer1Categories;
    result.layer2Category = layer2Categories;

    return result;
  }
}
