class AuthTokens {
  final String accessToken;
  final String idToken;
  final String? refreshToken;

  AuthTokens({
    required this.accessToken,
    required this.idToken,
    this.refreshToken,
  });
}
