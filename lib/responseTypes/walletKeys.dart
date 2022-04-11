import 'dart:convert';

class WalletKeys {
  final String address;
  final String privateKey;

  const WalletKeys({
    required this.address,
    required this.privateKey,
  });

  factory WalletKeys.parseBody(String jsonString) {
    var json = jsonDecode(jsonString);
    return WalletKeys(
      address: json['address'],
      privateKey: json['privateKey'],
    );
  }
}
