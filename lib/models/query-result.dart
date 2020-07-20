import 'package:storeFlutter/models/filter-type.dart';

class QueryResult<T> {
  int page;
  int pageSize;
  int total;
  List<FilterMeta> filterMetas;

  List<T> items;
}
