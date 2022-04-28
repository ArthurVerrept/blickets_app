import 'dart:convert';

class Event {
  final String contractAddress;
  final String eventDate;
  final String eventName;
  final String symbol;
  final String ticketAmount;
  final String ticketNumber;
  final String tokenURI;

   const Event({
    required this.contractAddress,
    required this.eventDate,
    required this.eventName,
    required this.symbol,
    required this.ticketAmount,
    required this.ticketNumber,
    required this.tokenURI,
  });

  static Event fromJson(json) {
    return Event(
        contractAddress: json['contractAddress'],
        eventDate: json['eventDate'],
        eventName: json['eventName'],
        symbol: json['symbol'],
        ticketAmount: json['ticketAmount'],
        ticketNumber: json['ticketNumber'],
        tokenURI: json['tokenURI'],
    );
  }
}

class EventList {
  final List<Event> events;

  const EventList({
    required this.events,
  });

  factory EventList.parseBody(String jsonString) {
    dynamic l = json.decode(jsonString);
    List<Event> posts = List<Event>.from(l['events'].map((model)=> Event.fromJson(model)));
    return EventList(events: posts);
  }
}

// class MyEvents {
//   final EventList events;

//   const EventList({
//     required this.events,
//   });

//   factory EventList.parseBody(String jsonString) {
//     dynamic l = json.decode(jsonString);
//     List<Event> posts = List<Event>.from(l.events.map((model)=> Event.fromJson(model)));
//     return EventList(events: posts);
//   }
// }
