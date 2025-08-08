enum DaysOfWeek {
  monday(1, 'M', 'Mon'),
  tuesday(2, 'T', 'Tue'),
  wednesday(3, 'W', 'Wed'),
  thursday(4, 'T', 'Thu'),
  friday(5, 'F', 'Fri'),
  saturday(6, 'S', 'Sat'),
  sunday(7, 'S', 'Sun');

  const DaysOfWeek(this.weekDay, this.weekDayCode, this.threeLetterCode);
  final int weekDay;
  final String weekDayCode;
  final String threeLetterCode;
}
