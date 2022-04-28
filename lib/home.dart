import 'package:blickets_app/responseTypes/allEvents.dart';
import 'package:blickets_app/responseTypes/imageLink.dart';
import 'package:blickets_app/responseTypes/myEvents.dart';
import 'package:blickets_app/responseTypes/walletKeys.dart';
import 'package:blickets_app/widgets/event.dart';
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
  List<UserEvent>? myEvents;
  List<Event>? allEvents;
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
            style: TextStyle(color: Color(0xff323232)),
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
              padding: const EdgeInsets.fromLTRB(8, 16, 8, 8),
            ),
            IconButton(
              icon: const Icon(Icons.bookmark_outline),
              onPressed: () {},
              padding: const EdgeInsets.fromLTRB(8, 16, 8, 8),
            ),
            IconButton(
              icon: const Icon(Icons.account_balance_wallet),
              onPressed: () {},
              padding: const EdgeInsets.fromLTRB(8, 16, 8, 8),
            )
          ],
        ),
      ),
      body: Container(
        width: double.infinity,
        child: ListView(
          scrollDirection: Axis.vertical,
          children: [
            loading == false
                ? Container(
                    width: double.infinity,
                    child: Column(
                      children: [
                        Container(
                          alignment: AlignmentDirectional.centerStart,
                          padding: const EdgeInsets.only(left: 25, top: 10),
                          child: const Text(
                            'My Tickets',
                            style: TextStyle(
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.bold,
                              fontSize: 24,
                              color: Color(0xff323232),
                            ),
                          ),
                        ),
                        Container(
                          width: double.infinity,
                          height: 230,
                          child: Stack(
                            alignment: AlignmentDirectional.center,
                            children: List.generate(myEvents!.length, (index) {
                              return Positioned(
                                top: double.parse(index.toString()) * 15 - 15,
                                // : EdgeInsets.only(top: double.parse(index.toString())),
                                child: TicketWidget(event: myEvents![index]),
                              );
                            }),
                          ),
                        ),
                      ],
                    ),
                  )
                : const Text('loading'),
            loading == false
                ? Container(
                    child: Container(
                      alignment: AlignmentDirectional.centerStart,
                      padding: const EdgeInsets.only(top: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: EdgeInsets.only(left: 25),
                            child: Column(
                              children: const [
                                Text(
                                  'Events',
                                  style: TextStyle(
                                    fontFamily: 'Montserrat',
                                    fontWeight: FontWeight.bold,
                                    fontSize: 24,
                                    color: Color(0xff323232),
                                  ),
                                ),
                                Text(
                                  'Upcoming',
                                  style: TextStyle(
                                    fontFamily: 'Montserrat',
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                    color: Color(0xff323232),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            height: 300,
                            child: ListView(
                              padding: EdgeInsets.only(left: 25),
                              scrollDirection: Axis.horizontal,
                              children:
                                  List.generate(allEvents!.length, (index) {
                                // : EdgeInsets.only(top: double.parse(index.toString())),
                                return EventWidget(event: allEvents![index]);
                              }),
                            ),
                          )
                        ],
                      ),
                    ),
                  )
                : const Text('loading')
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

    AllEventList allEventsRes = await get(
      '/event/all-events',
      returnType: AllEventList.parseBody,
      headers: {},
    );

    setState(() {
      myEvents = myEventsRes.events.sublist(0, 4);
      if (allEventsRes.events.length > 10) {
        allEvents = allEventsRes.events.sublist(0, 10);
      } else {
        allEvents = allEventsRes.events;
      }

      loading = false;
    });
  }
}
