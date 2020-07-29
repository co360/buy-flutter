import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:storeFlutter/models/auth/access-token.dart';
import 'package:storeFlutter/models/auth/login-status.dart';
import 'package:storeFlutter/models/auth/refresh-token.dart';
import 'package:storeFlutter/services/auth-service.dart';
import 'package:storeFlutter/services/storage-service.dart';

class DioTokenInterceptors extends InterceptorsWrapper {
  final Dio _dio;
  final StorageService _storageService = GetIt.I<StorageService>();

  DioTokenInterceptors(this._dio);

  @override
  Future onRequest(RequestOptions options) async {
    if (!options.headers.containsKey('skiptoken')) {
      print('accessToken: ${_storageService.accessToken}');
      String accessToken = _storageService.accessToken;

      if (accessToken != null)
        options.headers.addAll({'Authorization': 'Bearer $accessToken'});
    } else {
      options.headers.remove('skiptoken');
    }

    return options;
  }

  @override
  Future onError(DioError dioError) async {
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

      if (token.error != null) {
        // login with guest
        print("error refershing the token... should login with guest now");

        _storageService.clearSession();

        LoginStatus status = await authService.loginAsGuest();

        if (status.error != null) {
          super.onError(status.dioError);
        } else {
          // shouldn't do anything as the the access token is already done at login as guest
        }
      } else {
        String newAccessToken = token.accessToken;
        String newRefreshToken = token.refreshToken;
        _storageService.accessToken = newAccessToken;
        _storageService.refreshToken = newRefreshToken;
      }

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
