import 'package:ishop/dev/const_logger/const_log_printer.dart';
import 'package:ishop/dev/const_logger/const_output_event.dart';

/// Log output receives a [ConstOutputEvent] from a [ConstLogPrinter]
/// and sends it to the
/// desired destination.
///
/// This can be an output stream, a file or a network target.
/// [ConstLogOutput] may
/// cache multiple log messages.
abstract class ConstLogOutput {
  /// default const constructor
  const ConstLogOutput();

  /// init method
  void init() {}

  /// output method
  void output(ConstOutputEvent event);

  /// destroy method
  void destroy() {}
}
