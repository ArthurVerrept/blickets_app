import 'package:blickets_app/responseTypes/allEvents.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

import '../responseTypes/imageLink.dart';

class EventWidget extends StatefulWidget {
  final Event event;
  EventWidget({Key? key, required this.event}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _EventWidgetState();
  }
}

class _EventWidgetState extends State<EventWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.antiAlias,
      padding: const EdgeInsets.all(15),
      width: 300,
      height: 300,
      margin: const EdgeInsets.only(top: 15, right: 12.5),
      decoration: BoxDecoration(
        color: Color.fromARGB(255, 47, 47, 47),
        image: DecorationImage(
          image: NetworkImage(widget.event.imageUrl),
          fit: BoxFit.cover,
          opacity: 0.6,
        ),
        // borderRadius: BorderRadius.all(
        //   Radius.circular(10),
        // ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.event.eventName,
                style: const TextStyle(
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.w800,
                  fontSize: 22,
                  color: Colors.white,
                ),
              ),
              Container(
                padding: EdgeInsets.only(top: 6),
                child: Text(
                  '(' + widget.event.symbol + ')',
                  style: const TextStyle(
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                    color: Colors.white,
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.only(top: 6),
                child: Text(
                  'Date: ' + getDate(widget.event.eventDate),
                  style: const TextStyle(
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                    color: Colors.white,
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.only(top: 6),
                child: Text(
                  'Ether: ' +
                      double.parse(widget.event.ticketPrice).toStringAsFixed(6),
                  style: const TextStyle(
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
  }
}

String getDate(String date) {
  final day = DateTime.fromMillisecondsSinceEpoch(int.parse(date)).day;
  final month = DateTime.fromMillisecondsSinceEpoch(int.parse(date)).month;
  final year = DateTime.fromMillisecondsSinceEpoch(int.parse(date)).year;
  return day.toString() + '/' + month.toString() + '/' + year.toString();
}
