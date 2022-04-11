import 'package:blickets_app/responseTypes/walletKeys.dart';
import 'package:flutter/material.dart';

import 'helpers/request.dart';

class Home extends StatefulWidget {
  final String accessToken;
  final String refreshToken;
  Home({Key? key, required this.accessToken, required this.refreshToken})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _HomeState();
  }
}

class _HomeState extends State<Home> {
  List users = [];

  Future<void> test() async {
    try {
      WalletKeys walletKeys = await post(
        '/blockchain/create-ethereum-account',
        returnType: WalletKeys.parseBody,
      );
      print(walletKeys);
    } catch (error) {
      print(error);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const Center(
          child: Text(
            'profile',
            style: TextStyle(color: Colors.black),
          ),
        ),
        title: const Text('Blickets'),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.settings),
            tooltip: 'Show Snackbar',
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('This is a snackbar')));
            },
          )
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            IconButton(icon: const Icon(Icons.home), onPressed: test),
            IconButton(
                icon: const Icon(Icons.bookmark_outline), onPressed: () {}),
            IconButton(
                icon: const Icon(Icons.account_balance_wallet),
                onPressed: () {}),
          ],
        ),
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        child: Center(
          child: Text('widget.album.title'),
        ),
      ),
    );
  }
}
