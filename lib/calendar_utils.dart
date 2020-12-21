int getNumberOfWeeksInMonth(DateTime date) {
  DateTime dateTime = DateTime(date.year, date.month, 1);
  int noOfDays = getNumberOfDaysInMonth(date);
  int noOfDaysInStartWeek = 7 - dateTime.weekday;
  int numberOfWeeks = (noOfDays - noOfDaysInStartWeek) ~/ 7; // ~/ --> truncateing integer divison opertor
  numberOfWeeks += (noOfDays - noOfDaysInStartWeek) % 7 != 0 ? 1 : 0;
  if (noOfDaysInStartWeek > 0) numberOfWeeks++; //add a week for the noOfDaysInStartWeek

  return numberOfWeeks;
}

int getNumberOfDaysInMonth(DateTime date) {
  DateTime dateTime = DateTime(date.year, date.month, 1);
  DateTime nextMonth = DateTime(date.year, date.month + 1, 1);
  Duration duration = nextMonth.difference(dateTime);

  return duration.inDays;
}
