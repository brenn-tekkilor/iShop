import 'package:logger/logger.dart';

abstract class ConstLogFilter {
  const ConstLogFilter({Level lvl = _defaultLevel}) : level = lvl;
  final Level level;
  ConstLogFilter init() {
    return this;
  }

  /// Is called every time a new log message is sent and decides if
  /// it will be printed or canceled.
  ///
  /// Returns `true` if the message should be logged.
  bool shouldLog(LogEvent event);

  void destroy() {}

  static const _defaultLevel = Level.verbose;
}
