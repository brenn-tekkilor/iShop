import 'package:ishop/dev/const_logger/const_log_event.dart';

/// Const Log Printer
abstract class ConstLogPrinter {
  /// Const Log Printer default const constructor
  const ConstLogPrinter();

  /// Is called every time a new [ConstLogEvent] is sent and handles printing or
  /// storing the message.
  List<String> log(ConstLogEvent event);

  /// destroy
  void destroy() {}
}
