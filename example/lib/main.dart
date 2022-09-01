import 'package:event_calendar/calendar_event.dart';
import 'package:event_calendar/calendar_flutter.dart';
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
    setCalendarEvents(); // uncomment this to see the events on the calendar
    return Scaffold(
      appBar: AppBar(
        title: const Text('Calendar'),
      ),
      body: CustomCalendar(),
    );
  }

  void setCalendarEvents() {
    List<CalendarEvent> eventsList = <CalendarEvent>[];

    CalendarEvent event = CalendarEvent();
    event.title = "Meeting 1";
    event.startTime = DateTime(2022, 11, 01);
    event.endTime = DateTime(2022, 11, 10);
    event.bgColor = Colors.redAccent;
    eventsList.add(event);

    event = CalendarEvent();
    event.title = "Meeting 2";
    event.startTime = DateTime(2022, 11, 09);
    event.endTime = DateTime(2022, 11, 11);
    event.bgColor = Colors.redAccent;
    eventsList.add(event);

    event = CalendarEvent();
    event.title = "Meeting 3";
    event.startTime = DateTime(2022, 11, 09);
    event.endTime = DateTime(2022, 11, 11);
    event.bgColor = Colors.green;
    eventsList.add(event);

    event = CalendarEvent();
    event.title = "Meeting 4";
    event.startTime = DateTime.now().subtract(const Duration(days: 1));
    event.endTime = DateTime.now().add(const Duration(days: 1));
    event.bgColor = Colors.purple;
    eventsList.add(event);

    event = CalendarEvent();
    event.title = "Meeting 5";
    event.startTime = DateTime.now().add(const Duration(days: 1));
    event.endTime = DateTime.now().add(const Duration(days: 1));
    event.bgColor = Colors.orange;
    eventsList.add(event);

    event = CalendarEvent();
    event.title = "Meeting 6";
    event.startTime = DateTime(2022, 9, 01);
    event.endTime = DateTime(2022, 9, 10);
    event.bgColor = Colors.redAccent;
    eventsList.add(event);

    CalendarEvent.setListAndUpdateMap(eventsList);
  }
}
