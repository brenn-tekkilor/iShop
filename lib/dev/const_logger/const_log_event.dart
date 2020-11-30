import 'package:ishop/dev/const_logger/const_level.dart';

/// const log event
class ConstLogEvent {
  /// const log event default const constructor
  const ConstLogEvent(this.level, this.message, this.error, this.stackTrace);

  /// level
  final ConstLevel level;

  /// message
  final dynamic message;

  /// error
  final dynamic error;

  /// stacktrace
  final StackTrace stackTrace;
}
