import 'package:flutter/foundation.dart';

enum EventType {
   classEvent, examEvent, taskDueEvent, breakEvent, prepTimeEvent, eventsEvent 
}

@immutable
class Event {
  final String title;
  EventType? eventType;

   Event({this.title = "Title", this.eventType});

  @override
  bool operator ==(Object other) => other is Event && title == other.title;

  @override
  int get hashCode => super.hashCode;

  @override
  String toString() => title;
}
