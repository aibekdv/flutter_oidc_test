import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter_appauth/flutter_appauth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutteroidctest/core/config/oidc_config.dart';
import 'package:flutteroidctest/main.dart';
import 'package:flutteroidctest/module/presentation/cubit/app_cubit.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/models.dart';

class ApiService {
  final FlutterAppAuth _appAuth;
  final SharedPreferences _prefs;
  final Dio _dio;

  ApiService(this._appAuth, this._dio, this._prefs) {
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          final accessToken = _prefs.getString('accessToken');
          log("Access token: $accessToken", name: 'API');
          if (accessToken != null) {
            options.headers['Authorization'] = 'Bearer $accessToken';
          }
          return handler.next(options);
        },
        onError: (error, handler) async {
          final auth = BlocProvider.of<AppCubit>(navigatorKey.currentContext!);
          if (error.response?.statusCode == 401) {
            await auth.refreshAccessToken();
            return handler.resolve(
              await _dio.request(
                error.requestOptions.path,
                options: Options(headers: error.requestOptions.headers),
                data: error.requestOptions.data,
              ),
            );
          }
          return handler.next(error);
        },
      ),
    );
  }

  _saveTokens(AuthTokens tokens) async {
    await _prefs.setString('accessToken', tokens.accessToken);
    await _prefs.setString('idToken', tokens.idToken);
    await _prefs.setString('refreshToken', tokens.refreshToken ?? '');
  }

  Future<void> login() async {
    try {
      final result = await _appAuth.authorizeAndExchangeCode(
        AuthorizationTokenRequest(
          OidcConfig.clientId,
          OidcConfig.redirectUri,
          issuer: OidcConfig.issuer,
          scopes: ['openid', 'profile', 'email', 'offline_access'],
          promptValues: ['login'],
        ),
      );

      _saveTokens(AuthTokens(
        accessToken: result.accessToken!,
        idToken: result.idToken!,
        refreshToken: result.refreshToken,
      ));
    } catch (e) {
      log("Login failed: $e");
      throw Exception('Login failed: $e');
    }
  }

  Future<void> refreshToken() async {
    try {
      final refreshToken = _prefs.getString('refreshToken');
      if (refreshToken == null) {
        throw Exception('No refresh token available');
      }
      final result = await _appAuth.token(
        TokenRequest(
          OidcConfig.clientId,
          OidcConfig.redirectUri,
          issuer: OidcConfig.issuer,
          refreshToken: refreshToken,
        ),
      );

      _saveTokens(AuthTokens(
        accessToken: result.accessToken!,
        idToken: result.idToken!,
        refreshToken: result.refreshToken,
      ));
    } catch (e) {
      log("Refresh token failed: $e");
      throw Exception('Refresh token failed: $e');
    }
  }

  Future<UserInfo> getUserInfo() async {
    try {
      final response = await _dio.get(OidcConfig.userInfoEndpoint);

      if (response.statusCode != 200) {
        throw Exception('Failed to fetch user info');
      }

      final data = response.data;
      return UserInfo.fromJson(data);
    } catch (e) {
      log("Get user info failed: $e");
      throw Exception('Get user info failed: $e');
    }
  }

  Future<void> logout() async {
    await _appAuth.endSession(EndSessionRequest(
      idTokenHint: _prefs.getString('idToken'),
      postLogoutRedirectUrl: OidcConfig.redirectUri,
      issuer: OidcConfig.issuer,
    ));
    await _prefs.remove('accessToken');
    await _prefs.remove('idToken');
    await _prefs.remove('refreshToken');
  }
}
