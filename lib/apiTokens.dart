import 'dart:convert';

class ApiTokens {
  final String accessToken;
  final String refreshToken;

  const ApiTokens({
    required this.accessToken,
    required this.refreshToken,
  });

  factory ApiTokens.parseBody(String jsonString) {
    var json = jsonDecode(jsonString);
    return ApiTokens(
      accessToken: json['accessToken'],
      refreshToken: json['refreshToken'],
    );
  }
}
