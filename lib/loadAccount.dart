import 'package:blickets_app/responseTypes/walletKeys.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'helpers/request.dart';

class LoadAccount extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return LoadAccountState();
  }
}

// TODO: handle google permissions accept but api fail (revoke permissions)
// TODO: make sure if refresh token exists on phone it doesn't call google-authentication/login but just gets a new access token
// TODO: create wakeup for api on heroku

class LoadAccountState extends State<LoadAccount> {
  final storage = new FlutterSecureStorage();
  final String apiURL = 'http://10.0.2.2:3000/user/google-login';
  String? accessToken;
  String? refreshToken;

  Future<void> test() async {
    try {
      WalletKeys walletKeys = await post('/blockchain/create-ethereum-account',
          returnType: WalletKeys.parseBody,
          headers: {
            'Authorization':
                'Bearer yJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiIxMjM0NTY3ODkwIiwibmFtZSI6IkpvaG4gRG9lIiwiaWF0IjoxNTE2MjM5MDIyfQ.SflKxwRJSMeKKF2QT4fwpMeJf36POk6yJV_adQssw5c'
          });
      // await storage.write(
      //   key: 'accessToken',
      //   value: tokens.accessToken == null ? null : tokens.accessToken,
      // );

    } catch (error) {
      print(error);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.only(top: 60),
              width: double.infinity,
              child: Column(
                children: [
                  const Text(
                    'Create/ Load Your Ethereum Account',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'Shrikhand',
                      fontSize: 22,
                      color: Color(0xffE43C4A),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: test,
                    child: const Text('Create New Wallet'),
                    style: ElevatedButton.styleFrom(
                      side: const BorderSide(
                          width: 2.0, color: Color(0xffE43C4A)),
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.vertical()),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
