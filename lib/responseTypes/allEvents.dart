import 'dart:convert';

class Event {
  final String eventName;
  final String symbol;
  final String imageUrl;
  final String contractAddress;
  final String eventDate;
  final String ticketPrice;
  final String ticketAmount;
  final String ticketIdCounter;

  const Event({
    required this.eventName,
    required this.symbol,
    required this.imageUrl,
    required this.contractAddress,
    required this.eventDate,
    required this.ticketPrice,
    required this.ticketAmount,
    required this.ticketIdCounter,
  });

  static Event fromJson(json) {
    return Event(
      contractAddress: json['contractAddress'],
      eventDate: json['eventDate'],
      eventName: json['eventName'],
      symbol: json['symbol'],
      ticketPrice: json['ticketPrice'],
      ticketAmount: json['ticketAmount'],
      ticketIdCounter: json['ticketIdCounter'],
      imageUrl: json['imageUrl'],
    );
  }
}

class AllEventList {
  final List<Event> events;

  const AllEventList({
    required this.events,
  });

  factory AllEventList.parseBody(String jsonString) {
    dynamic l = json.decode(jsonString);
    List<Event> posts =
        List<Event>.from(l['events'].map((model) => Event.fromJson(model)));
    return AllEventList(events: posts);
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
