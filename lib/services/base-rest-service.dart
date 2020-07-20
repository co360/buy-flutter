import 'package:dio/dio.dart';
import 'package:storeFlutter/services/dio-logging-interceptors.dart';
import 'package:storeFlutter/services/dio-token-interceptors.dart';

abstract class BaseRestService {
  final Dio _dio = new Dio();
  final Dio _noTokenDio = new Dio();
  final String _baseUrl = 'https://office.smarttradzt.com:8001/';

  BaseRestService() {
    _dio.options.baseUrl = _baseUrl;
    _dio.interceptors.add(DioLoggingInterceptors(_dio));
    _dio.interceptors.add(DioTokenInterceptors(_dio));

    _noTokenDio.options.baseUrl = _baseUrl;
    _noTokenDio.interceptors.add(DioLoggingInterceptors(_noTokenDio));
  }

  Dio get dio {
    return _dio;
  }

  Dio get noTokenDio => _noTokenDio; //  String get baseUrl => _baseUrl;

  Future<bool> canAccessSecureResources() {
    // TODO check if it's connected?

    // TODO check got token in secure

    // TODO check need to refresh token?

    // TODO if not login as guest or throw error then display the notification

    // TODO check is it expiry? or only through the invocation?
  }
}
