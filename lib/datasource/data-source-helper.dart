import 'package:quiver/strings.dart';
import 'package:storeFlutter/models/label-value.dart';

class DataSourceHelper {
  DataSourceHelper._();

  static String getLabel({String value, List<LabelValue> lvs}) {
    if (isBlank(value)) return "";
    if (lvs == null || lvs.length == 0) return value;
    LabelValue lv = lvs.firstWhere((element) => element.value == value);

    if (lv != null) return lv.label;
    return value;
  }

  static String getLabels({List<String> values, List<LabelValue> lvs}) {
    if (values == null || values.length == 0) return "";
    if (lvs == null || lvs.length == 0) {
      return values.join(", ");
    }
    List<String> labels =
        values.map<String>((e) => getLabel(value: e, lvs: lvs)).toList();

    return labels.join(", ");
  }
}
