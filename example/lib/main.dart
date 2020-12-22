// import 'package:calendar_flutter/calendar_event.dart';
// import 'package:calendar_flutter/flutter_calendar.dart';
// import 'package:calendar_flutter/calendar_flutter.dart';
import 'package:event_calendar/calendar_event.dart';
import 'package:event_calendar/calendar_flutter.dart';
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
    setCalendarEvents(); // uncomment this to see the events on the calendar
    return Scaffold(
      appBar: AppBar(
        title: Text('Calendar'),
      ),
      body: CustomCalendar(),
    );
  }

  void setCalendarEvents() {
    List<CalendarEvent> eventsList = List<CalendarEvent>();

    CalendarEvent event = CalendarEvent();
    event.title = "Meeting 1";
    event.startTime = DateTime(2020, 11, 01);
    event.endTime = DateTime(2020, 12, 10);
    event.bgColor = Colors.redAccent;
    eventsList.add(event);

    event = CalendarEvent();
    event.title = "Meeting 2";
    event.startTime = DateTime(2020, 11, 01);
    event.endTime = DateTime(2020, 12, 10);
    event.bgColor = Colors.purple;
    eventsList.add(event);

    event = CalendarEvent();
    event.title = "Meeting 3";
    event.startTime = DateTime(2020, 11, 01);
    event.endTime = DateTime(2020, 12, 10);
    event.bgColor = Colors.green;
    eventsList.add(event);

    event = CalendarEvent();
    event.title = "Meeting 4";
    event.startTime = DateTime(2020, 12, 01);
    event.endTime = DateTime(2020, 12, 09);
    event.bgColor = Colors.orange;
    eventsList.add(event);

    event = CalendarEvent();
    event.title = "Meeting 5";
    event.startTime = DateTime(2020, 12, 09);
    event.endTime = DateTime(2020, 12, 09);
    event.bgColor = Colors.orange;
    eventsList.add(event);

    CalendarEvent.setListAndUpdateMap(eventsList);
  }
}
