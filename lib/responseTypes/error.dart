import 'dart:convert';

class Error {
  final int statusCode;
  final String message;

  const Error({
    required this.statusCode,
    required this.message,
  });

  factory Error.parseBody(String jsonString) {
    var json = jsonDecode(jsonString);
    return Error(
      statusCode: json['statusCode'],
      message: json['message'],
    );
  }
}
