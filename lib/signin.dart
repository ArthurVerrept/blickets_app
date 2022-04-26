import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_signin_button/button_list.dart';
import 'package:flutter_signin_button/button_view.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'responseTypes/tokens.dart';
import './home.dart';
import 'helpers/request.dart';



class SignIn extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return SignInState();
  }
}

// TODO: handle google permissions accept but api fail (revoke permissions)
// TODO: make sure if refresh token exists on phone it doesn't call google-authentication/login but just gets a new access token
// TODO: create wakeup for api on heroku

class SignInState extends State<SignIn> {
  final storage = new FlutterSecureStorage();
  String? accessToken;
  String? refreshToken;

  Future<void> _handleSignIn() async {
    GoogleSignIn _googleSignIn;

    if(Platform.isAndroid) {
      _googleSignIn = GoogleSignIn(
        // ClientId needs to be there for android, however for apple
        // it is not needed to return a serverAuthCode
        // for apple you need to follow the step on the flutter website
        // AND you need to add SERVER_CLIENT_ID to the google-info.plist
        clientId:
            '267142607446-ea4jh5etipmenei9apdnog59gg4jc8o9.apps.googleusercontent.com',
        // hostedDomain: "",
        scopes: <String>['profile'],
      );
    }
    else {
      _googleSignIn = GoogleSignIn(
        scopes: <String>['profile'],
      );
    }
    

  
    try {
      GoogleSignInAccount? googleAccount = await _googleSignIn.signIn();
      print(googleAccount);
      if (googleAccount!.serverAuthCode != null) {
        Map<String, String> body = {
          'code': googleAccount.serverAuthCode!,
        };

        try {
          Tokens tokens = await post(
            '/user/google-login',
            returnType: Tokens.parseBody,
            body: body,
          );

          await storage.write(
            key: 'accessToken',
            value: tokens.accessToken == null ? null : tokens.accessToken,
          );
          await storage.write(
            key: 'refreshToken',
            value: tokens.refreshToken == null ? null : tokens.refreshToken,
          );
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => Home(
                accessToken: tokens.accessToken,
                refreshToken: tokens.refreshToken,
              ),
            ),
          );
        } catch (err) {
          // if our API fails here we will revoke access to the app which means
          // server auth token will be sent again by google on the next attempt
          await _googleSignIn.disconnect();
          await _googleSignIn.signOut();
        }
      } else {
        // TODO: handle no auth code bey error-ing
      }
    } catch (error) {
      print(error);
    }
  }

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
                children: [
                  const Text(
                    'Blickets',
                    style: TextStyle(
                      fontFamily: 'Shrikhand',
                      fontSize: 22,
                      color: Color(0xffE43C4A),
                    ),
                  ),
                  SignInButton(
                    Buttons.Google,
                    padding: EdgeInsets.all(3),
                    onPressed: _handleSignIn,
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
