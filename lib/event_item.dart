import 'package:event_calendar/calendar_event.dart';
import 'package:flutter/material.dart';

class EventItem extends StatelessWidget {
  const EventItem({
    @required this.onTap,
    this.event,
    this.horizontalPadding = 4,
    this.verticalPadding = 4,
    this.style,
  });

  final int verticalPadding;
  final int horizontalPadding;

  final CalendarEvent event;
  final VoidCallback onTap;
  final TextStyle style;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return InkWell(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          border: Border(
            left: BorderSide(
              width: 3,
              color: event.color,
            ),
          ),
          color: event.color.withOpacity(0.08),
        ),
        padding: const EdgeInsets.symmetric(
          vertical: 10,
          horizontal: 5,
        ),
        child: Text(
          event.title,
          style: style ?? textTheme.bodyText2.copyWith(fontSize: 14),
        ),
      ),
    );
  }
}
