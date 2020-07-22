class ResourceUtil {
  // TODO the baseurl and upload service name need to be externalize
  static final String _baseUrl = 'https://office.smarttradzt.com:8001/';
  static final String _uploadServiceName = 'buy-commons-service/';

  static String fullPath(String resource) {
    return _baseUrl + '/' + _uploadServiceName + '/' + resource;
  }
}
