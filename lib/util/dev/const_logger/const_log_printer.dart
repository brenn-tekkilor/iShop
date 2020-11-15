import 'package:logger/logger.dart';

abstract class ConstLogPrinter {
  const ConstLogPrinter();
  void init() {}

  /// Is called every time a new [LogEvent] is sent and handles printing or
  /// storing the message.
  List<String> log(LogEvent event);

  void destroy() {}
}
