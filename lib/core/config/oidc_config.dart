class OidcConfig {
  static const String clientId = 'interactive.public';
  static const String redirectUri = 'com.example.flutteroidctest://callback';
  static const String issuer = 'https://demo.duendesoftware.com';
  static const String authorizationEndpoint = '$issuer/connect/authorize';
  static const String tokenEndpoint = '$issuer/connect/token';
  static const String userInfoEndpoint = '$issuer/connect/userinfo';
}