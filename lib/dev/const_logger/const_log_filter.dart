import 'package:ishop/dev/const_logger/const_level.dart';
import 'package:ishop/dev/const_logger/const_log_event.dart';

/// abstract class Const Log Filter
abstract class ConstLogFilter {
  /// Const Log Filter const default constructor
  const ConstLogFilter({this.level = _defaultLevel});

  /// log level
  final ConstLevel level;

  /// Is called every time a new log message is sent and decides if
  /// it will be printed or canceled.
  ///
  /// Returns `true` if the message should be logged.
  bool shouldLog(ConstLogEvent event);
  static const _defaultLevel = ConstLevel.verbose;
}
