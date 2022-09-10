# event_calendar

A package that displays a calendar with multiple events.

## Installation

```yaml
dependencies:
    event_calendar: 0.1.0

dependency_overrides:
    event_calendar:
        git: https://github.com/rynssnjn/event_calendar.git
```

## Usage

Initializing an event. The [EventModel] requires a [String] for the `title` and a [DateTime] for both `startDate` and `endDate`. It can also accept an optional value for a [VoidCallback] `onSelect` that is triggered when the event is tapped as well as optional value for [TextStyle] and [Color] for customizing the UI of the event.

```dart
EventModel(
    title: 'Meeting 1',
    startDate: DateTime(2022, 9, 2),
    endDate: DateTime(2022, 9, 10),
    backgroundColor: const Color(0xff31C987),
)
```

Displaying the calendar with events. Calling [EventCalendar] makes you display the calendar with events. It has a required property called `holder` wherein you can customize the user interface of the weekdays via [CalendarHolder], weekends and the months. It accepts a list of [EventModel] to show the events on the calendar itself.

```dart
EventCalendar(
    holder: CalendarHolder(),
    calendarSize: MediaQuery.of(context).size,
    events: events,
    divisor: 2,
    dateBorderColor: Colors.black,
)
