import 'dart:convert';

class Tokens {
  final String accessToken;
  final String refreshToken;

  const Tokens({
    required this.accessToken,
    required this.refreshToken,
  });

  factory Tokens.parseBody(String jsonString) {
    var json = jsonDecode(jsonString);
    return Tokens(
      accessToken: json['accessToken'],
      refreshToken: json['refreshToken'],
    );
  }
}
