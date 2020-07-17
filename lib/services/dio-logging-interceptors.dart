import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:storeFlutter/models/auth/access-token.dart';
import 'package:storeFlutter/models/auth/refresh-token.dart';
import 'package:storeFlutter/services/auth-service.dart';
import 'package:storeFlutter/services/storage-service.dart';

class DioLoggingInterceptors extends InterceptorsWrapper {
  final Dio _dio;
  final StorageService _storageService = GetIt.I<StorageService>();

  DioLoggingInterceptors(this._dio);

  @override
  Future onRequest(RequestOptions options) async {
    print(
        "--> ${options.method != null ? options.method.toUpperCase() : 'METHOD'} ${"" + (options.baseUrl ?? "") + (options.path ?? "")}");
    print("Headers:");
    options.headers.forEach((k, v) => print('$k: $v'));
    if (options.queryParameters != null) {
      print("queryParameters:");
      options.queryParameters.forEach((k, v) => print('$k: $v'));
    }
    if (options.data != null) {
      print("Body: ${options.data}");
    }
    print(
        "--> END ${options.method != null ? options.method.toUpperCase() : 'METHOD'}");

    if (!options.headers.containsKey('skiptoken')) {
      print('accessToken: ${_storageService.accessToken}');
      String accessToken = _storageService.accessToken;

      if (accessToken != null)
        options.headers.addAll({'Authorization': 'Bearer $accessToken'});
    } else {
      options.headers.remove('skiptoken');
    }

//    String accessToken = _sharedPreferencesService
//        .getString(SharedPreferencesService.keyAccessToken);

    return options;
  }

  @override
  Future onResponse(Response response) {
    print(
        "<-- ${response.statusCode} ${(response.request != null ? (response.request.baseUrl + response.request.path) : 'URL')}");
    print("Headers:");
    response.headers?.forEach((k, v) => print('$k: $v'));
    print("Response: ${response.data}");
    print("<-- END HTTP");
    return super.onResponse(response);
  }

  @override
  Future onError(DioError dioError) async {
    print(
        "<-- ${dioError.message} ${(dioError.response?.request != null ? (dioError.response.request.baseUrl + dioError.response.request.path) : 'URL')}");
    print(
        "${dioError.response != null ? dioError.response.data : 'Unknown Error'}");
    print("<-- End error");

    int responseCode = dioError.response.statusCode;
    String oldAccessToken = _storageService.accessToken;

    if (oldAccessToken != null &&
        responseCode == 401 &&
        _storageService != null) {
      _dio.interceptors.requestLock.lock();
      _dio.interceptors.responseLock.lock();

      String refreshToken = _storageService.refreshToken;

      RefreshToken refreshTokenBody =
          RefreshToken('refresh_token', refreshToken);
//      ApiAuthRepository apiAuthRepository = ApiAuthRepository();
      AuthService authService = GetIt.I<AuthService>();
      AccessToken token = await authService.refreshAuth(refreshTokenBody);
      String newAccessToken = token.accessToken;
      String newRefreshToken = token.refreshToken;
      _storageService.accessToken = newAccessToken;
      _storageService.refreshToken = newRefreshToken;

      RequestOptions options = dioError.response.request;
//      options.headers.addAll({'requirestoken': true});
      _dio.interceptors.requestLock.unlock();
      _dio.interceptors.responseLock.unlock();
      return _dio.request(options.path, options: options);
    } else {
      super.onError(dioError);
    }
  }
}
