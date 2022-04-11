import 'dart:convert';

class AccessToken {
  final String accessToken;

  const AccessToken({
    required this.accessToken,
  });

  factory AccessToken.parseBody(String jsonString) {
    var json = jsonDecode(jsonString);
    return AccessToken(
      accessToken: json['accessToken'],
    );
  }
}
