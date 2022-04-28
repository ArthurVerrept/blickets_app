import 'package:blickets_app/responseTypes/myEvents.dart';
import 'package:blickets_app/responseTypes/walletKeys.dart';
import 'package:blickets_app/widgets/ticket.dart';
import 'package:flutter/material.dart';
import 'dart:developer';

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
  String myEventsString = '';
  EventList? myEvents;
  bool loading = true;

  Future<void> test() async {
    try {
      // WalletKeys walletKeys = await post(
      //   '/blockchain/create-ethereum-account',
      //   returnType: WalletKeys.parseBody,
      // );

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
            IconButton(
              icon: const Icon(Icons.home),
              onPressed: test,
              padding: EdgeInsets.fromLTRB(8, 16, 8, 8),
            ),
            IconButton(
              icon: const Icon(Icons.bookmark_outline),
              onPressed: () {},
              padding: EdgeInsets.fromLTRB(8, 16, 8, 8),
            ),
            IconButton(
              icon: const Icon(Icons.account_balance_wallet),
              onPressed: () {},
              padding: EdgeInsets.fromLTRB(8, 16, 8, 8),
            )
          ],
        ),
      ),
      body: Container(
        width: double.infinity,
        child: Column(
          children: [
            loading == false
                ? Container(
                    width: double.infinity,
                    height: 300,
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.blueAccent)),
                    child: Stack(
                      alignment: AlignmentDirectional.center,
                      fit: StackFit.loose,
                      children: List.generate(myEvents!.events.length, (index) {
                        return Positioned(
                          top: double.parse(index.toString()) * 20,
                          // : EdgeInsets.only(top: double.parse(index.toString())),
                          child: TicketWidget(event: myEvents!.events[index]),
                        );
                      }),
                    ),
                  )
                : Text('loading'),
            // Image.network('https://picsum.photos/250?image=9'),
            // child: Card(
            // ),
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    doSomeAsyncStuff();
  }

  Future<void> doSomeAsyncStuff() async {
    EventList myEventsRes = await get(
      '/blockchain/my-events',
      returnType: EventList.parseBody,
      headers: {},
    );
    setState(() {
      myEvents = myEventsRes;
      loading = false;
    });
  }
}
