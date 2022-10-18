import 'package:event_calendar/event_calendar.dart';
import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    final events = [
      EventModel(
        title: 'Meeting 1',
        startDate: DateTime(2022, 10, 2),
        endDate: DateTime(2022, 10, 3),
        backgroundColor: const Color(0xff31C987),
      ),
      EventModel(
        title: 'Meeting 2',
        startDate: DateTime(2022, 10, 5),
        endDate: DateTime(2022, 10, 8),
        backgroundColor: const Color(0xff31C987),
      ),
      EventModel(
        title: 'Meeting 3',
        startDate: DateTime(2022, 12, 3),
        endDate: DateTime(2022, 12, 09),
        backgroundColor: const Color(0xff892486),
      ),
      EventModel(
        title: 'Meeting 4',
        startDate: DateTime(2022, 12, 09),
        endDate: DateTime(2022, 12, 12),
        backgroundColor: const Color(0xff892486),
      ),
      EventModel(
        title: 'Meeting 5',
        startDate: DateTime(2022, 12, 12),
        endDate: DateTime(2022, 12, 12),
        backgroundColor: const Color(0xff892486),
      ),
      EventModel(
        title: 'Meeting 6',
        startDate: DateTime(2022, 12, 12),
        endDate: DateTime(2022, 12, 15),
        backgroundColor: const Color(0xff31C987),
      ),
      EventModel(
        title: 'Meeting 7',
        startDate: DateTime(2022, 12, 6),
        endDate: DateTime(2022, 12, 7),
        backgroundColor: const Color(0xff892486),
      ),
      EventModel(
        title: 'Meeting 8',
        startDate: DateTime(2022, 12, 12),
        endDate: DateTime(2022, 12, 12),
        backgroundColor: const Color(0xff31C987),
      ),
      EventModel(
        title: 'Meeting 9',
        startDate: DateTime(2022, 12, 12),
        endDate: DateTime(2022, 12, 12),
        backgroundColor: const Color(0xff31C987),
      ),
      EventModel(
        title: 'Meeting 10',
        startDate: DateTime(2022, 12, 13),
        endDate: DateTime(2022, 12, 18),
        backgroundColor: const Color(0xff31C987),
      ),
      EventModel(
        title: 'Meeting 11',
        startDate: DateTime(2022, 12, 15),
        endDate: DateTime(2022, 12, 22),
        backgroundColor: const Color(0xff892486),
      ),
      EventModel(
        title: 'Meeting 12',
        startDate: DateTime(2022, 12, 21),
        endDate: DateTime(2022, 12, 24),
        backgroundColor: const Color(0xff31C987),
      ),
      EventModel(
        title: 'Meeting 13',
        startDate: DateTime(2022, 12, 10),
        endDate: DateTime(2022, 12, 10),
        backgroundColor: const Color(0xff31C987),
      ),
      EventModel(
        title: 'Meeting 14',
        startDate: DateTime(2022, 12, 8),
        endDate: DateTime(2022, 12, 10),
        backgroundColor: const Color(0xff31C987),
      ),
      EventModel(
        title: 'Rael birthday',
        startDate: DateTime(2021, 04, 23),
        endDate: DateTime(2021, 04, 23),
        backgroundColor: const Color(0xff31C987),
      ),
    ];
    return Scaffold(
      appBar: AppBar(
        title: const Text('Test Calendar'),
        backgroundColor: const Color(0xff509D56),
      ),
      body: EventCalendar(
        holder: CalendarHolder(),
        calendarSize: MediaQuery.of(context).size,
        events: events,
        divisor: 2,
        dateBorderColor: Colors.black,
      ),
    );
  }
}
