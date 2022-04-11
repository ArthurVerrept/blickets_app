import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'dart:async';
import './home.dart';
import 'loadAccount.dart';
import 'signIn.dart';

class SplashScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return SplashScreenState();
  }
}

class SplashScreenState extends State<SplashScreen> {
  final storage = new FlutterSecureStorage();
  String? accessToken;
  String? refreshToken;
  String? address;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              height: 100,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: const [
                  Text(
                    'Blickets',
                    style: TextStyle(
                      fontFamily: 'Shrikhand',
                      fontSize: 22,
                      color: Color(0xffE43C4A),
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

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _getTokens();
    });
  }

  _getTokens() async {
    accessToken = await storage.read(key: 'accessToken');
    refreshToken = await storage.read(key: 'refreshToken');
    address = await storage.read(key: 'address');

    Timer(const Duration(seconds: 2), () {
      if (refreshToken != null && accessToken != null) {
        // if no address create/import account
        // if (address != null) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => Home(
              accessToken: accessToken!,
              refreshToken: accessToken!,
            ),
          ),
        );
        // } else {
        //   Navigator.push(
        //     context,
        //     MaterialPageRoute(
        //       builder: (context) => LoadAccount(),
        //     ),
        //   );
        // }
      } else {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => SignIn(),
          ),
        );
      }
    });
  }
}
