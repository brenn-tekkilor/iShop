/// EventTimePeriod
/// 0 = 12:00 am
/// 1439 = 11:59 pm
class EventTimePeriod {
  /// EventTimePeriod constructor
  const EventTimePeriod({this.start = 0, this.end = 1439});

  /// start minute
  final int start;

  /// end minute
  final int end;

  /// is24Hours
  bool get is24Hours => start + end >= 1439;
}
