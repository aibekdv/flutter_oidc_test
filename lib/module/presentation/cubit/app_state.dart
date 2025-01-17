part of 'app_cubit.dart';

@immutable
sealed class AppState {}

final class AppInitial extends AppState {}

final class LoginLoading extends AppState {}

final class LoginLoaded extends AppState {}

final class LoginFailure extends AppState {}

// get user info

final class UserInfoLoaded extends AppState {
  final UserInfo userInfo;

  UserInfoLoaded(this.userInfo);
}

final class UserInfoFailure extends AppState {}

final class UserInfoLoading extends AppState {}

// Refresh token

final class RefreshLoading extends AppState {}

final class RefreshLoaded extends AppState {}

final class RefreshFailure extends AppState {}


// Logout

final class LogoutLoading extends AppState {}

final class LogoutLoaded extends AppState {}

final class LogoutFailure extends AppState {}