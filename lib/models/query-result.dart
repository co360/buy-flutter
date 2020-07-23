import 'package:storeFlutter/models/filter-type.dart';

class QueryResult<T> {
  int page;
  int pageSize;
  int total;
  List<FilterMeta> filterMetas;

  List<T> items;

  bool hasMorePage() {
    if (total == 0 || pageSize == 0) return false;

    return (total / pageSize).ceil() > page + 1;
  }
}
