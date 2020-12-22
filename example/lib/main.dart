import 'package:event_calendar/calendar_event.dart';
import 'package:event_calendar/event_calendar.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<EventModel> events;
  @override
  void initState() {
    setEvents();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('CALENDAR'),
      ),
      body: EventCalendar(
        weekDays: ['Mo.', 'Di.', 'Mi.', 'Do.', 'Fr.', 'Sa.', 'So.'],
        calendarSize: MediaQuery.of(context).size,
      ),
    );
  }

  void setEvents() {
    List<EventModel> events = List<EventModel>();

    EventModel event = EventModel(
      onSelect: () => print('Test1'),
      title: 'Meeting 1',
      startTime: DateTime(2020, 11, 01),
      endTime: DateTime(2020, 12, 10),
      backgroundColor: Color(0xff31C987),
    );
    events.add(event);

    EventModel event2 = EventModel(
      onSelect: () => print('Test2'),
      title: 'Meeting 2',
      startTime: DateTime(2020, 11, 01),
      endTime: DateTime(2020, 12, 10),
      backgroundColor: Color(0xff892486),
    );
    events.add(event2);

    EventModel event3 = EventModel(
      title: 'Meeting 3',
      startTime: DateTime(2020, 11, 01),
      endTime: DateTime(2020, 12, 10),
      backgroundColor: Color(0xff892486),
    );
    events.add(event3);

    EventModel event4 = EventModel(
      title: 'Meeting 4',
      startTime: DateTime(2020, 12, 01),
      endTime: DateTime(2020, 12, 09),
      backgroundColor: Color(0xff892486),
    );
    events.add(event4);

    EventModel event5 = EventModel(
      title: 'Meeting 5',
      startTime: DateTime(2020, 12, 09),
      endTime: DateTime(2020, 12, 12),
      backgroundColor: Color(0xff31C987),
    );
    events.add(event5);

    EventModel event6 = EventModel(
      title: 'Meeting 6',
      startTime: DateTime(2020, 12, 12),
      endTime: DateTime(2020, 12, 12),
      backgroundColor: Color(0xff892486),
    );
    events.add(event6);

    EventModel event7 = EventModel(
      title: 'Meeting 7',
      startTime: DateTime(2020, 12, 12),
      endTime: DateTime(2020, 12, 12),
      backgroundColor: Color(0xff31C987),
    );
    events.add(event7);

    EventModel event8 = EventModel(
      title: 'Meeting 8',
      startTime: DateTime(2020, 12, 10),
      endTime: DateTime(2020, 12, 11),
      backgroundColor: Color(0xff892486),
    );
    events.add(event8);

    EventModel event9 = EventModel(
      title: 'Meeting 9',
      startTime: DateTime(2020, 12, 12),
      endTime: DateTime(2020, 12, 12),
      backgroundColor: Color(0xff31C987),
    );
    events.add(event9);

    EventModel event10 = EventModel(
      title: 'Meeting 10',
      startTime: DateTime(2020, 12, 12),
      endTime: DateTime(2020, 12, 12),
      backgroundColor: Color(0xff31C987),
    );
    events.add(event10);

    EventModel.setListAndUpdateMap(events);
  }
}
