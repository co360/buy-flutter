import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:get_it/get_it.dart';
import 'package:storeFlutter/models/auth/access-token.dart';
import 'package:storeFlutter/models/auth/current-user.dart';
import 'package:storeFlutter/models/auth/login-body.dart';
import 'package:storeFlutter/models/auth/login-status.dart';
import 'package:storeFlutter/models/auth/refresh-token.dart';
import 'package:storeFlutter/services/base-rest-service.dart';
import 'package:storeFlutter/services/storage-service.dart';

class AuthService extends BaseRestService {
  final String clientId = 'browser';
  final String clientSecret = 'secret';

  StorageService _storageService = GetIt.I<StorageService>();

  Future<LoginStatus> loginAsGuest() async {
    LoginStatus status =
        await this.loginUser(LoginBody('guest', 'Password@123'));

    if (status.success) {
      return LoginStatus.guest();
    } else {
      return status;
    }
  }

  Future<LoginStatus> loginUser(LoginBody loginBody) async {
    print('calling loginuser');
    try {
      Map<String, dynamic> params = {
        'grant_type': 'password',
        'scope': 'ui',
        'timestamp': new DateTime.now().millisecondsSinceEpoch.toString(),
      };

      params.addAll(loginBody.toJson());

      final response = await noTokenDio.post(
        'buy-auth-service/uaa/oauth/token',
        data: params,
        options: Options(
          contentType: Headers.formUrlEncodedContentType,
          headers: {
            'skiptoken': true,
            'Authorization': 'Basic ${base64Encode(
              utf8.encode('$clientId:$clientSecret'),
            )}',
          },
        ),
      );
      AccessToken token = AccessToken.fromJson(response.data);

      // store inside shared preference
      String newAccessToken = token.accessToken;
      String newRefreshToken = token.refreshToken;
      _storageService.accessToken = newAccessToken;
      _storageService.refreshToken = newRefreshToken;

      print("setting new token ${_storageService.accessToken}");

      if (loginBody.username != 'guest') {
        // load all the thing here...
      }

      return LoginStatus.success();
    } catch (error, stacktrace) {
      _printError(error, stacktrace);
      if (error != null &&
          error.response != null &&
          error.response.data != null) {
        if (error.response.data['error_description'] != null) {
          return LoginStatus.error(
              error.response.data['error_description'], error);
        }
        return LoginStatus.error('${error.response.data}', error);
      }
      return LoginStatus.error('$error', error);
    }
  }

  Future<AccessToken> refreshAuth(RefreshToken refreshTokenBody) async {
    print("calling refresh token");

    try {
      final response = await noTokenDio.post(
        'oauth/token',
        data: FormData.fromMap(refreshTokenBody.toJson()),
        options: Options(
          contentType: Headers.formUrlEncodedContentType,
          headers: {
            'skiptoken': true,
            'Authorization': 'Basic ${base64Encode(
              utf8.encode('$clientId:$clientSecret'),
            )}',
          },
        ),
      );
      return AccessToken.fromJson(response.data);
    } catch (error, stacktrace) {
      print('refresh token error $error');
      _printError(error, stacktrace);
      if (error != null &&
          error.response != null &&
          error.response.data != null) {
        print(error.response.data);
        return AccessToken.withError('${error.response.data}');
      }
      return AccessToken.withError('$error');
    }
  }

  Future<void> logout() async {
    String refreshToken = _storageService.refreshToken;

    if (refreshToken != null) {
      final response = await dio.get(
        'buy-auth-service/uaa/users/revokeUser/' + refreshToken,
        options: Options(
          contentType: Headers.formUrlEncodedContentType,
        ),
      );
    }
    await _storageService.clearSession();

    return;
  }

  Future<CurrentUser> currentUser() async {
    final response = await dio.get('buy-auth-service/uaa/users/current-user');
    return CurrentUser.fromJson(response.data);
  }

  void _printError(error, StackTrace stacktrace) {
    debugPrint('debug print error: $error & stacktrace: $stacktrace');
  }
}
