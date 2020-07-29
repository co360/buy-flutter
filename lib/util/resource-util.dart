import 'package:quiver/strings.dart';

class ResourceUtil {
  // TODO the baseurl and upload service name need to be externalize
  static final String _baseUrl = 'https://office.smarttradzt.com:8022/';
  static final String _uploadServiceName = 'store-commons-service/';

  static String fullPath(String resource) {
    return _baseUrl + '/' + _uploadServiceName + '/' + resource;
  }

  static String fullPathImageHtml(String html) {
    if (isNotBlank(html)) {
      RegExp regExp = new RegExp(
        r'\<img src="file-repo',
        caseSensitive: false,
        multiLine: true,
      );

      String resp = html.replaceAll(
          regExp, '<img src="$_baseUrl/$_uploadServiceName/file-repo');

      return resp;
    }
    return html;
  }
}
