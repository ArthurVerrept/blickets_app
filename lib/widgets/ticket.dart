import 'package:blickets_app/responseTypes/myEvents.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

import '../responseTypes/imageLink.dart';

class TicketWidget extends StatefulWidget {
  final UserEvent event;
  TicketWidget({Key? key, required this.event}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _TicketWidgetState();
  }
}

class _TicketWidgetState extends State<TicketWidget> {
  ImageProvider<Object> image = const AssetImage('lib/assets/images/grey.jpeg');
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(15),
      width: MediaQuery.of(context).size.width - 50,
      height: 150,
      margin: EdgeInsets.only(top: 30),
      decoration: BoxDecoration(
        color: Color.fromARGB(255, 47, 47, 47),
        image: DecorationImage(
          image: image,
          fit: BoxFit.cover,
          opacity: 0.6,
        ),
        borderRadius: BorderRadius.all(
          Radius.circular(10),
        ),
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
                padding: EdgeInsets.only(top: 2),
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
                padding: EdgeInsets.only(top: 2),
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
            ],
          ),
          Column(
            children: [
              Container(
                padding: EdgeInsets.only(top: 30),
                alignment: AlignmentDirectional.bottomCenter,
                child: const Text(
                  'Ticket Number',
                  style: TextStyle(
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                    color: Colors.white,
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.only(top: 2),
                alignment: AlignmentDirectional.bottomCenter,
                child: Text(
                  '#' +
                      widget.event.ticketNumber +
                      ' of ' +
                      widget.event.ticketAmount,
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
    doSomeAsyncStuff();
  }

  Future<void> doSomeAsyncStuff() async {
    final res = await http.get(Uri.parse(widget.event.tokenURI));
    ImageLink imgLink = ImageLink.parseBody(res.body);

    setState(() {
      image = NetworkImage(imgLink.image);
    });
  }
}

String getDate(String date) {
  final day = DateTime.fromMillisecondsSinceEpoch(int.parse(date)).day;
  final month = DateTime.fromMillisecondsSinceEpoch(int.parse(date)).month;
  final year = DateTime.fromMillisecondsSinceEpoch(int.parse(date)).year;
  return day.toString() + '/' + month.toString() + '/' + year.toString();
}
