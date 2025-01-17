import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutteroidctest/module/data/services/api_service.dart';
import 'package:meta/meta.dart';

import '../../data/models/models.dart';

part 'app_state.dart';

class AppCubit extends Cubit<AppState> {
  final ApiService _apiService;
  AppCubit(this._apiService) : super(AppInitial());

  Future<void> login() async {
    emit(LoginLoading());
    try {
      await _apiService.login();
      emit(LoginLoaded());
    } catch (e) {
      emit(LoginFailure());
    }
  }

  Future<void> refreshAccessToken() async {
    emit(RefreshLoading());
    try {
      await _apiService.refreshToken();
      emit(RefreshLoaded());
    } catch (e) {
      emit(RefreshFailure());
      logout();
    }
  }

  Future<void> fetchUserInfo() async {
    emit(UserInfoLoading());
    try {
      final res = await _apiService.getUserInfo();
      emit(UserInfoLoaded(res));
    } catch (e) {
      log("Get user info failed: $e");
      emit(UserInfoFailure());
      logout();
    }
  }

  Future<void> logout() async {
    emit(LogoutLoading());
    try {
      await _apiService.logout();
      emit(LogoutLoaded());
    } catch (e) {
      emit(LogoutFailure());
    }
  }
}
