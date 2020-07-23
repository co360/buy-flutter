import 'package:storeFlutter/models/filter-type.dart';

class SearchParam {
  List<SearchFilter> filters;
}

class SearchFilter {
  String name;
  String code;
  String path;
  List<FilterValue> values;
}
