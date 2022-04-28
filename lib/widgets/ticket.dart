import 'package:blickets_app/responseTypes/myEvents.dart';
import 'package:flutter/material.dart';

class TicketWidget extends StatefulWidget {
  final Event event;
  TicketWidget({Key? key, required this.event}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _TicketWidgetState();
  }
}

class _TicketWidgetState extends State<TicketWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(15),
      width: MediaQuery.of(context).size.width - 40,
      height: 150,
      margin: EdgeInsets.only(top: 30),
      decoration: const BoxDecoration(
        color: Color.fromARGB(255, 47, 47, 47),
        image: DecorationImage(
          image: NetworkImage(
              'https://bafybeieqjo6kvnwrbbfbtklef36wbqt5etlv75naeuwtg7awpstiakyhmi.ipfs.nftstorage.link/b9fd6c75-093b-425b-9aaa-daa53c924eea?fbclid=IwAR0yj5OOKCM-druWi3CqAI1FqwyzH4vcl008e4uSbq_BLcg4miGMIGkcUyQ'),
          fit: BoxFit.cover,
          opacity: 0.6,
        ),
        borderRadius: BorderRadius.all(
          Radius.circular(20),
        ),
        // boxShadow: [
        //   BoxShadow(
        //     color: Colors.black38,
        //     spreadRadius: -4,
        //     blurRadius: 5,
        //     offset: Offset(0, -6), // changes position of shadow
        //   ),
        // ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(widget.event.eventName),
          Text(widget.event.symbol),
          Text(
            DateTime.fromMillisecondsSinceEpoch(
                    int.parse(widget.event.eventDate))
                .month
                .toString(),
          ),
          Text(widget.event.ticketNumber),
        ],
      ),
    );
  }
}
