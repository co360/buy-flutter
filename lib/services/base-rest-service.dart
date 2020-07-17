import 'package:dio/dio.dart';
import 'package:storeFlutter/services/dio-logging-interceptors.dart';

abstract class BaseRestService {
  final Dio _dio = new Dio();
  final String _baseUrl = 'https://office.smarttradzt.com:8001/';

  BaseRestService() {
    _dio.options.baseUrl = _baseUrl;
    _dio.interceptors.add(DioLoggingInterceptors(_dio));
  }

  Dio get dio {
    return _dio;
  }

  Future<bool> canAccessSecureResources() {
    // TODO check if it's connected?

    // TODO check got token in secure

    // TODO check need to refresh token?

    // TODO if not login as guest or throw error then display the notification

    // TODO check is it expiry? or only through the invocation?
  }
}
