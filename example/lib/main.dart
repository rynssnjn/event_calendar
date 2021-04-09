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
  @override
  Widget build(BuildContext context) {
    final events = [
      EventModel(
        title: 'Meeting 1',
        startTime: DateTime(2020, 11, 1),
        endTime: DateTime(2020, 12, 5),
        backgroundColor: Color(0xff31C987),
      ),
      EventModel(
        title: 'Meeting 3',
        startTime: DateTime(2020, 12, 3),
        endTime: DateTime(2020, 12, 09),
        backgroundColor: Color(0xff892486),
      ),
      EventModel(
        title: 'Meeting 4',
        startTime: DateTime(2020, 12, 09),
        endTime: DateTime(2020, 12, 12),
        backgroundColor: Color(0xff892486),
      ),
      EventModel(
        title: 'Meeting 5',
        startTime: DateTime(2020, 12, 12),
        endTime: DateTime(2020, 12, 12),
        backgroundColor: Color(0xff892486),
      ),
      EventModel(
        title: 'Meeting 6',
        startTime: DateTime(2020, 12, 12),
        endTime: DateTime(2020, 12, 15),
        backgroundColor: Color(0xff31C987),
      ),
      EventModel(
        title: 'Meeting 7',
        startTime: DateTime(2020, 12, 6),
        endTime: DateTime(2020, 12, 7),
        backgroundColor: Color(0xff892486),
      ),
      EventModel(
        title: 'Meeting 8',
        startTime: DateTime(2020, 12, 12),
        endTime: DateTime(2020, 12, 12),
        backgroundColor: Color(0xff31C987),
      ),
      EventModel(
        title: 'Meeting 9',
        startTime: DateTime(2020, 12, 12),
        endTime: DateTime(2020, 12, 12),
        backgroundColor: Color(0xff31C987),
      ),
      EventModel(
        title: 'Meeting 10',
        startTime: DateTime(2020, 12, 13),
        endTime: DateTime(2020, 12, 18),
        backgroundColor: Color(0xff31C987),
      ),
      EventModel(
        title: 'Meeting 11',
        startTime: DateTime(2020, 12, 15),
        endTime: DateTime(2020, 12, 22),
        backgroundColor: Color(0xff892486),
      ),
      EventModel(
        title: 'Meeting 12',
        startTime: DateTime(2020, 12, 21),
        endTime: DateTime(2020, 12, 24),
        backgroundColor: Color(0xff31C987),
      ),
      EventModel(
        title: 'Meeting 13',
        startTime: DateTime(2020, 12, 10),
        endTime: DateTime(2020, 12, 10),
        backgroundColor: Color(0xff31C987),
      ),
      EventModel(
        title: 'Meeting 14',
        startTime: DateTime(2020, 12, 8),
        endTime: DateTime(2020, 12, 10),
        backgroundColor: Color(0xff31C987),
      ),
      EventModel(
        title: 'Rael birthday',
        startTime: DateTime(2021, 04, 23),
        endTime: DateTime(2021, 04, 23),
        backgroundColor: Color(0xff31C987),
      ),
    ];
    return Scaffold(
      appBar: AppBar(
        title: Text('Test Calendar'),
        backgroundColor: Color(0xff509D56),
      ),
      body: EventCalendar(
        calendarSize: MediaQuery.of(context).size,
        events: events,
      ),
    );
  }
}
